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

    # 可选配置: RestClient timeout, etc.
    # key 必须是符号
    def rest_client_options
      if config.nil?
        return {timeout: 5, open_timeout: 5, verify_ssl: true}
      end
      config.rest_client_options
    end
  end

  class Config
    attr_accessor :redis, :rest_client_options
  end
end
