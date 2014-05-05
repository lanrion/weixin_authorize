require "spec_helper"

describe WeixinAuthorize::Api::Qrcode do

  it "#create_qr_scene" do
    response = $client.create_qr_scene("123")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["ticket", "expire_seconds"])
    expect(response.result["expire_seconds"]).to eq(1800)
  end

  it "#create_qr_limit_scene" do
    response = $client.create_qr_limit_scene("1234")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["ticket"])
  end
  
  it "#return_qr_url" do
    response = $client.create_qr_limit_scene("1234")
    qr_url = $client.qr_code_url(response.result["ticket"])
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(qr_url).to include("mp.weixin.qq.com")
  end
end
