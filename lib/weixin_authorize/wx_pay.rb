module WeixinAuthorize
  class WxPay
    class << self

      def http_post_without_token(url, payload={}, headers={})
        post_api_url = payment_endpoint + url
        r = RestClient::Request.execute(
              {
                method: :post,
                url: post_api_url,
                payload: payload,
                headers: {content_type: 'application/xml'}
              })
        load_xml(r)
      end

      def load_xml(string)
        PayResult.new Hash.from_xml(string)
      end

      def generate(pay_key, params)
        query = params.sort.map do |key, value|
          "#{key}=#{value}"
        end.join('&')
        Digest::MD5.hexdigest("#{query}&key=#{pay_key}").upcase
      end

      def make_payload(pay_key, params)
      "<xml>#{params.map { |k, v| "<#{k}>#{v}</#{k}>" }.join}<sign>#{generate(pay_key, params)}</sign></xml>"
      end

      def verify?(pay_key, params)
        params = params.dup
        sign = params.delete('sign') || params.delete(:sign)
        generate(pay_key, params) == sign
      end

      private
        def payment_endpoint
          "https://api.mch.weixin.qq.com/"
        end
    end
  end
end
