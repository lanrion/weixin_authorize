module WeixinAuthorize
  module JsTicket
    class RedisStore < Store
      JSTICKET = "jsticket"
      EXPIRED_AT = "expired_at"

      def jsticket_expired?
        weixin_redis.hvals(client.jsticket_redis_key).empty?
      end

      def refresh_jsticket
        super
        weixin_redis.hmset(
          client.jsticket_redis_key,
          JSTICKET,
          client.jsticket,
          EXPIRED_AT,
          client.jsticket_expired_at
        )
        weixin_redis.expireat(
          client.jsticket_redis_key,
          client.jsticket_expired_at.to_i
        )
      end

      def jsticket
        super
        client.jsticket = weixin_redis.hget(client.jsticket_redis_key, JSTICKET)
        client.jsticket_expired_at = weixin_redis.hget(
          client.jsticket_redis_key,
          EXPIRED_AT
        )
        client.jsticket
      end

      def weixin_redis
        WeixinAuthorize.weixin_redis
      end
    end
  end
end
