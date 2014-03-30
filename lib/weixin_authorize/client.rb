# encoding: utf-8
require "redis"
require 'digest'
module WeixinAuthorize

  class Client
    include Api::User
    include Api::Menu
    include Api::Custom
    include Api::Groups
    include Api::Qrcode
    include Api::Media

    attr_accessor :app_id, :app_secret, :expired_at # Time.now + expires_in
    attr_accessor :access_token, :redis_key
    attr_accessor :storage

    def initialize(app_id, app_secret, redis_key=nil)
      @app_id     = app_id
      @app_secret = app_secret
      @expired_at = Time.now.to_i
      @redis_key  = security_redis_key((redis_key || "weixin_" + app_id))
      @storage    = Storage.init_with(weixin_redis || self)
    end

    # return token
    def get_access_token
      authenticate if token_expired?
      if !is_weixin_redis_blank?
        self.access_token = weixin_redis.hget(redis_key, "access_token")
        self.expired_at   = weixin_redis.hget(redis_key, "expired_at")
      end
      @access_token
    end

    # 检查appid和app_secret是否有效。
    def is_valid?
      # 重新验证，清除存储在Redis的access_token
      weixin_redis.del(redis_key) if !is_weixin_redis_blank?
      valid_result = http_get_access_token
      if valid_result.keys.include?("access_token")
        set_access_token_for_client(valid_result)
        return true
      end
      false
    end

    def token_expired?
      if is_weixin_redis_blank?
        # 如果当前token过期时间小于现在的时间，则重新获取一次
        @expired_at <= Time.now.to_i
      else
        weixin_redis.hvals(redis_key).empty?
      end
    end

    private

      # authenticate access_token
      def authenticate
        raise "APPID or APPSECRET is invalid" if !is_valid?
        set_access_token_for_client
        if !is_weixin_redis_blank?
          authenticate_with_redis
        end
      end

      def authenticate_with_redis
        weixin_redis.hmset(redis_key, :access_token, access_token, :expired_at, expired_at)
        weixin_redis.expireat(redis_key, expired_at.to_i-10) # 提前10秒超时
      end

      def set_access_token_for_client(access_token_infos=nil)
        token_infos = access_token_infos || http_get_access_token
        self.access_token = token_infos["access_token"]
        self.expired_at   = Time.now.to_i + token_infos["expires_in"].to_i
      end

      def http_get_access_token
        hash_infos = http_get_without_token("/token", authenticate_options)
        hash_infos
      end

      def authenticate_options
        {grant_type: "client_credential", appid: app_id, secret: app_secret}
      end

      def access_token_param
        {access_token: get_access_token}
      end

      def http_get_without_token(url, options={}, endpoint="plain")
        get_api_url = endpoint_url(endpoint) + url
        JSON.parse(RestClient.get(get_api_url, :params => options))
      end

      def http_get(url, options={})
        options = options.merge(access_token_param)
        http_get_without_token(url, options)
      end

      # Refactor
      def http_post(url, options={}, endpoint="plain")
        post_api_url = endpoint_url(endpoint) + url + "?access_token=#{get_access_token}"
        options      = MultiJson.dump(options) # to json
        JSON.parse(RestClient.post(post_api_url, options))
      end

      def endpoint_url(endpoint)
        send("#{endpoint}_endpoint")
      end

      def plain_endpoint
        "https://api.weixin.qq.com/cgi-bin"
      end

      def file_endpoint
        "http://file.api.weixin.qq.com/cgi-bin"
      end

      def weixin_redis
        return nil if WeixinAuthorize.config.nil?
        @redis ||= WeixinAuthorize.config.redis
      end

      def is_weixin_redis_blank?
        weixin_redis.nil?
      end

      def security_redis_key(key)
        Digest::MD5.hexdigest(key.to_s).upcase
      end

  end
end
