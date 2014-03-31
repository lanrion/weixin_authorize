# encoding: utf-8
module WeixinAuthorize

  class Storage

    attr_accessor :client

    def initialize(client)
      @client = client
    end

    def self.init_with(client)
      if WeixinAuthorize.config.redis.nil?
        ClientStorage.new(client)
      else
        RedisStorage.new(client)
      end
    end

    def valid?
      valid_result = http_get_access_token
      if valid_result.keys.include?("access_token")
        set_access_token_for_client(valid_result)
        return true
      end
      false
    end

    def token_expired?
      raise NotImplementedError, "Subclasses must implement a token_expired? method"
    end

    def authenticate
      raise "APPID or APPSECRET is invalid" if !valid?
      set_access_token_for_client
    end

    def access_token
      authenticate if token_expired?
    end

    def set_access_token_for_client(access_token_infos=nil)
      token_infos = access_token_infos || http_get_access_token
      client.access_token = token_infos["access_token"]
      client.expired_at   = Time.now.to_i + token_infos["expires_in"].to_i
    end

    def http_get_access_token
      WeixinAuthorize.http_get_without_token("/token", authenticate_headers)
    end

    def authenticate_headers
      {grant_type: "client_credential", appid: client.app_id, secret: client.app_secret}
    end

  end

end
