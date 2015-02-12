module WeixinAuthorize
  module JsTicket
    class ObjectStore < Store

      def jsticket_expired?
        # 如果当前token过期时间小于现在的时间，则重新获取一次
        client.jsticket_expired_at <= Time.now.to_i
      end

      def jsticket
        super
        client.jsticket
      end

      def refresh_jsticket
        super
      end

    end
  end
end
