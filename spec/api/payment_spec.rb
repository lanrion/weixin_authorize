require "spec_helper"

describe WeixinAuthorize::Api::Payment do
  it "can get prepay_id by unifiedorder" do
    # INVOKE_UNIFIEDORDER_REQUIRED_FIELDS = %i(body out_trade_no total_fee spbill_create_ip notify_url trade_type)
    params = {
      body: '测试商品',
      out_trade_no: 'test003',
      total_fee: 1,
      spbill_create_ip: '127.0.0.1',
      notify_url: ERB::Util.url_encode('http://making.dev/notify'),
      trade_type: 'JSAPI',
      mch_id: "1226509002",
      nonce_str: "5K8264ILTKCH16CQ2502SI8ZNMTM67VS",
      openid: ENV["OPENID"],
      appid: $client.app_id
    }

    params = {
      appid:  "wxd930ea5d5a258f4f",
      mch_id: "10000100",
      device_info: "1000",
      body: "test",
      nonce_str: "ibuaiVcKdpRxkhJA"
    }
    response = $client.unifiedorder(params)
    binding.pry
    puts response
  end
end
