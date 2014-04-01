# NOTE: the rspec should be test alonely.
require "spec_helper"
describe WeixinAuthorize::Client do
  describe "#get access_token" do
    it "return a access_token nil value before authenticate" do
      expect($client.access_token).to eq(nil)
    end

    it "appid and appsecret shoud be valid" do
      valid_info = $client.is_valid?
      expect(valid_info).to eq(true)
    end

    it "return the same access_token in the same thing twice" do
      access_token_1 = $client.get_access_token
      sleep 5
      access_token_2 = $client.get_access_token
      expect(access_token_1).to eq(access_token_2)
    end

    it "return errorcode and errormsg when appid or appsecret is invalid" do
      $client_1  = WeixinAuthorize::Client.new("appid", "app_secret")
      valid_info = $client_1.is_valid?
      expect(valid_info).to eq(false)
    end

    it "#get_access_token should raise error if app_secret or appid is invalid" do
      $client_2 = WeixinAuthorize::Client.new("appid_2", "app_secret_2")
      expect{$client_2.get_access_token}.to raise_error(RuntimeError)
    end

    it "#token_expired return the different access_token after token is expired" do
      token_1 = $client.get_access_token
      if WeixinAuthorize.weixin_redis.nil?
        $client.expired_at = Time.now.to_i - 7300
      else
        WeixinAuthorize.weixin_redis.del($client.redis_key)
      end
      token_2 = $client.get_access_token
      expect(token_1).to_not eq(token_2)
    end

  end
end
