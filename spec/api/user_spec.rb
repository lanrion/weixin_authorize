require "spec_helper"

describe WeixinAuthorize::Api::User do
  it "can get a weixin User info" do
    user_info = $client.user(ENV["OPENID"])
    expect(user_info.code).to eq(WeixinAuthorize::OK_CODE)
    expect(user_info.result["openid"]).to eq(ENV["OPENID"])
  end

  it "can get followers infos" do
    valid_info = $client.is_valid?
    expect(valid_info).to eq(true)
    followers = $client.followers
    expect(followers.code).to eq(WeixinAuthorize::OK_CODE)
    expect(followers.result.keys).to eq(["total", "count", "data", "next_openid"])

    valid_info = $client.is_valid?
    expect(valid_info).to eq(true)
    followers = $client.followers
    expect(followers.code).to eq(WeixinAuthorize::OK_CODE)
    expect(followers.result.keys).to eq(["total", "count", "data", "next_openid"])
  end
end
