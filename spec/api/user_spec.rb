require "spec_helper"

describe WeixinAuthorize::Api::User do
  it "can get a weixin User info" do
    user_info = $client.user(ENV["OPENID"])
    puts user_info
  end

  it "can get followers infos" do
    followers = $client.users
    puts followers
  end
end
