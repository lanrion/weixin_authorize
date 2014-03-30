# encoding: utf-8
module WeixinAuthorize

  class Storage

    attr_accessor :storage

    def initialize(storage)
      @storage = storage
    end

    def self.init_with(storage)
      if storage.is_a? Client
        ObjectStorage.new(storage)
      else
        RedisStorage.new(storage)
      end
    end

    def valid?
      raise NotImplementedError, "Subclasses must implement a valid? method"
    end

    def token_expired?
      raise NotImplementedError, "Subclasses must implement a token_expired? method"
    end

    def authenticate
      raise NotImplementedError, "Subclasses must implement a authenticate method"
    end

    def get_access_token

    end
  end

  class RedisStorage < Storage

    def valid?
     storage.del(storage.redis_key)
    end

    def token_expired?
      storage.hvals(redis_key).empty?
    end

    def authenticate

    end

  end

  class ObjectStorage < Storage

    def valid?

    end

    def token_expired?
      # 如果当前token过期时间小于现在的时间，则重新获取一次
      stoage.expired_at <= Time.now.to_i
    end

    def authenticate

    end
  end

end
