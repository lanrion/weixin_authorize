# encoding: utf-8
module WeixinAuthorize

  class Client
    include Api::User
    include Api::Menu
    include Api::Custom
    include Api::Groups

    attr_accessor :app_id, :app_secret, :expired_at # Time.now + expires_in
    attr_accessor :access_token

    # 对于多用户微信营销平台的对接，需要把每次的expired_at, access_token保存在Redis中
    # 每次使用，则可以从Redis中获取expired_at和access_token，即
    # @client = WeixinAuthorize::Client.new(appid, appsecret, expired_at, access_token)
    # 获取access_token，则仍然是：@client.get_access_token 来获取
    def initialize(app_id="", app_secret="", expired_at=nil, access_token=nil)
      @app_id       = app_id
      @app_secret   = app_secret
      @expired_at   = (expired_at.to_i || Time.now.to_i)
      @access_token = access_token
      yield self if block_given?
    end

    # return token
    def get_access_token
      # 如果当前token过期时间小于现在的时间，则重新获取一次
      authenticate if token_expired?
      @access_token
    end

    # authenticate access_token
    def authenticate
      hash_infos        = http_get_without_token("/token", authenticate_options)
      self.access_token = hash_infos["access_token"]
      self.expired_at   = Time.now.to_i + hash_infos["expires_in"]
    end

    def token_expired?
      @expired_at <= Time.now.to_i
    end

    private

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

  end
end
