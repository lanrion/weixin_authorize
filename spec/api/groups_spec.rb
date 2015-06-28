describe WeixinAuthorize::Api::Groups do

  let(:group_name) do
    "test group_name"
  end

  let(:group_name_2) do
    "test group_name_2"
  end

  let(:groups) do
    $client.groups
  end

  let(:last_group_id) do
    groups.result["groups"][-1]["id"]
  end

  it "#delete all group step by step" do
    group_ids = groups.result["groups"].collect{|group|group["id"]}
    group_ids.each do |group_id|
      res = $client.delete_group(group_id)
      if res.code.to_s != "45009"
        expect(res.code).to eq(WeixinAuthorize::OK_CODE)
      end
    end
  end

  it "create a group" do
    response = $client.create_group(group_name)
    if response.code == WeixinAuthorize::OK_CODE
      expect(response.result["group"]["name"]).to eq(group_name)
    else
      expect(response.code).to eq(-1)
      puts "WEIXIN says: system error"
    end
  end

  it "get groups" do
    expect(groups.result["groups"][-1]["name"]).to eq(group_name)
  end

  it "#get_group_for ENV['OPENID']" do
    group = $client.get_group_for(ENV["OPENID"])
    expect(group.result.keys).to eq(["groupid"])
  end

  it "#update_group_name" do
    response = $client.create_group(group_name)
    if response.code != WeixinAuthorize::OK_CODE
      expect(response.code).to eq(-1)
      puts "WEIXIN says: system error"
    else
      expect(response.result["group"]["name"]).to eq(group_name)
      response = $client.update_group_name(response.result["group"]["id"], group_name_2)
      expect(response.code).to eq(WeixinAuthorize::OK_CODE)
      groups = $client.groups
      expect(groups.result["groups"][-1]["name"]).to eq(group_name_2)
    end
  end

  it "#update_group_for_openid" do
    $client.update_group_for_openid(ENV["OPENID"], last_group_id)
    group = $client.get_group_for(ENV["OPENID"])
    expect(group.result["groupid"]).to eq(last_group_id)
    $client.update_group_for_openid(ENV["OPENID"], 0)
  end

  it "#batch update group for openids" do
    res = $client.batch_update_group_for_openids([ENV["OPENID"]], last_group_id)
    expect(res.code).to eq(WeixinAuthorize::OK_CODE)
  end

end
