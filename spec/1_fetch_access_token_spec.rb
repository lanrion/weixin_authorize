# NOTE: the rspec should be test alonely.
require "spec_helper"
describe WeixinAuthorize::Client do
  describe "#get access_token" do
    it "return a access_token nil value before authenticate" do
      expect($client.access_token).to eq(nil)
    end

    it "return access_token after authenticate" do
      $client.authenticate
      expect($client.access_token).not_to eq(nil)
    end

    it "return the same access_token in the same thing twice" do
      access_token_1 = $client.get_access_token
      sleep 5
      access_token_2 = $client.get_access_token
      expect(access_token_1).to eq(access_token_2)
    end
  end
end
