module WeixinAuthorize

  class << self

    attr_accessor :config

    def configure
      yield self.config ||= Config.new
    end

    def weixin_redis
      return nil if config.nil?
      @redis ||= config.redis
    end

    def key_expired
      config.key_expired rescue 100
    end

    # 可选配置: RestClient timeout, etc.
    # key 必须是符号
    # 如果出现 RestClient::SSLCertificateNotVerified Exception: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed
    # 这个错，除了改 verify_ssl: true，请参考：http://www.extendi.it/blog/2015/5/23/47-sslv3-read-server-certificate-b-certificate-verify-failed
    def rest_client_options
      if config.nil?
        return {timeout: 5, open_timeout: 5, verify_ssl: true}
      end
      config.rest_client_options
    end
  end

  class Config
    attr_accessor :redis, :rest_client_options, :key_expired
  end
end
