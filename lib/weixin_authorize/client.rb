# encoding: utf-8
require "redis"
require 'digest/md5'
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
      @storage    = Storage.init_with(self)
    end

    # return token
    def get_access_token
      @storage.access_token
    end

    # 检查appid和app_secret是否有效。
    def is_valid?
      @storage.valid?
    end

    private

      def access_token_param
        {access_token: get_access_token}
      end

      def http_get(url, headers={}, endpoint="plain")
        headers = headers.merge(access_token_param)
        WeixinAuthorize.http_get_without_token(url, headers, endpoint)
      end

      def http_post(url, payload={}, headers={}, endpoint="plain")
        headers = access_token_param.merge(headers)
        WeixinAuthorize.http_post_without_token(url, payload, headers, endpoint)
      end

      def security_redis_key(key)
        Digest::MD5.hexdigest(key.to_s).upcase
      end

  end
end
