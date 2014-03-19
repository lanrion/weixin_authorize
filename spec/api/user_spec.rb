require "spec_helper"

describe WeixinAuthorize::Api::User do
  it "can get a weixin User info" do
    user_info = $client.user(ENV["OPENID"])
    expect(user_info["openid"]).to eq(ENV["OPENID"])
  end

  it "can get followers infos" do
    followers = $client.followers
    expect(followers.keys).to eq(["total", "count", "data", "next_openid"])
  end
end
