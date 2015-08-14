# encoding: utf-8
module WeixinAuthorize
  module Token
    class RedisStore < Store

      def valid?
       weixin_redis.del(client.redis_key)
       super
      end

      def token_expired?
        weixin_redis.hvals(client.redis_key).empty?
      end

      def refresh_token
        super
        weixin_redis.hmset(
          client.redis_key, "access_token",
          client.access_token, "expired_at",
          client.expired_at
        )
        weixin_redis.expireat(client.redis_key, client.expired_at.to_i-10) # 提前10秒超时
      end

      def access_token
        super
        client.access_token = weixin_redis.hget(client.redis_key, "access_token")
        client.expired_at   = weixin_redis.hget(client.redis_key, "expired_at")
        client.access_token
      end

      def weixin_redis
        WeixinAuthorize.weixin_redis
      end
    end
  end

end
