# encoding: utf-8
# 支付接口
module WeixinAuthorize
  module Api
    module Payment
      def unifiedorder(params)
        pay_post(
          "pay/unifiedorder",
          WxPay.make_payload(pay_key, params)
        )
      end

    end
  end
end
