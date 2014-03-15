# encoding: utf-8

module WeixinAuthorize

  class Client
    attr_accessor :app_id, :app_secret, :expired_at # Time.now + expires_in
    include Api::User
    include Api::Menu
    include Api::Custom
    include Api::Groups

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
      if @expired_at < Time.now.to_i
        authenticate
      end
      @access_token
    end

    # authenticate access_token
    def authenticate
      hash_infos        = JSON.parse(RestClient.get(authenticate_url))
      self.access_token = hash_infos["access_token"]
      self.expired_at   = Time.now.to_i + hash_infos["expires_in"]
    end

    private

      def authenticate_url
        "#{endpoint}/token?grant_type=client_credential&appid=#{app_id}&secret=#{app_secret}"
      end

      def endpoint
        "https://api.weixin.qq.com/cgi-bin"
      end

  end
end
