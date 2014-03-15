# encoding: utf-8
module WeixinAuthorize

  class Client
    include Api::User
    include Api::Menu
    include Api::Custom
    include Api::Groups

    attr_accessor :app_id, :app_secret, :expired_at # Time.now + expires_in
    attr_accessor :access_token

    def initialize(app_id="", app_secret="", expired_at=nil)
      @app_id     = app_id
      @app_secret = app_secret
      @expired_at = (expired_at.to_i || Time.now.to_i)
      yield self if block_given?
    end

    # return token
    def get_access_token
      # 如果当前token过期时间小于现在的时间，则重新获取一次
      if @expired_at <= Time.now.to_i
        authenticate
      end
      @access_token
    end

    # authenticate access_token
    def authenticate
      hash_infos        = http_get_without_token("/token", authenticate_options)
      self.access_token = hash_infos["access_token"]
      self.expired_at   = Time.now.to_i + hash_infos["expires_in"]
    end

    private

      def authenticate_options
        {grant_type: "client_credential", appid: app_id, secret: app_secret}
      end

      def endpoint
        "https://api.weixin.qq.com/cgi-bin"
      end

      def access_token_param
        {access_token: get_access_token}
      end

      def http_get_without_token(url, options={})
        get_api_url = endpoint + url
        JSON.parse(RestClient.get(get_api_url, :params => options))
      end

      def http_get(url, options={})
        options = options.merge(access_token_param)
        http_get_without_token(url, options)
      end

      # Refactor
      def http_post(url, options={})
        post_api_url = endpoint + url + "?access_token=#{get_access_token}"
        JSON.parse(RestClient.post(post_api_url ,options))
      end

  end
end
