require "spec_helper"

describe WeixinAuthorize::Client do
  describe "#get access_token" do
    it "returns a access_token value" do
      expect($client.app_id).not_to eq("ss")
    end
  end
end
