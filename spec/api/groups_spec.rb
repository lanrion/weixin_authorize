require "spec_helper"
describe WeixinAuthorize::Api::Groups do
  it "create a group" do
    response = $client.create_group("test")
    response
  end
end
