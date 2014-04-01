module WeixinAuthorize

  class << self

    attr_accessor :config

    def configure
      yield self.config ||= Config.new
    end

    def weixin_redis
      return nil if WeixinAuthorize.config.nil?
      @redis ||= WeixinAuthorize.config.redis
    end
  end

  class Config
    attr_accessor :redis
  end
end
