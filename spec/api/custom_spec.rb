require "spec_helper"

describe WeixinAuthorize::Api::Custom do
  it "can send a text Custom message" do
    response = $client.send_text_custom(ENV["OPENID"], "test send Custom Message")
    puts response
  end
end
