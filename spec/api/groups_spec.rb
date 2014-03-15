require "spec_helper"
describe WeixinAuthorize::Api::Groups do
  it "create a group" do
    response = $client.create_group("test")
    puts response
  end

  it "get groups" do
    groups = $client.groups
    puts groups
  end
end
