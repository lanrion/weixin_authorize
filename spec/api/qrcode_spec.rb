require "spec_helper"

describe WeixinAuthorize::Api::Qrcode do

  it "#create_qr_scene" do
    response = $client.create_qr_scene("123")
    expect(response.keys).to eq(["ticket", "expire_seconds"])
    expect(response["expire_seconds"]).to eq(1800)
  end

  it "#create_qr_limit_scene" do
    response = $client.create_qr_limit_scene("1234")
    expect(response.keys).to eq(["ticket"])
  end

end
