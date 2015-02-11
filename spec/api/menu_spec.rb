# encoding: utf-8
describe WeixinAuthorize::Api::Menu do

  it "can create a menu" do
    menu = '{"button":[{"type":"click","name":"今日歌曲","key":"V1001_TODAY_MUSIC"},{"type":"click","name":"歌手简介","key":"V1001_TODAY_SINGER"},{"name":"菜单","sub_button":[{"type":"view","name":"搜索","url":"http://www.soso.com/"},{"type":"view","name":"视频","url":"http://v.qq.com/"},{"type":"click","name":"赞一下我们","key":"V1001_GOOD"}]}]}'
    response = $client.create_menu(JSON.load(menu)) # or Json string
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
  end

  it "can't create a menu if invalid button size" do
    menu = '{"button":[]}'
    response = $client.create_menu(menu)
    expect(response.code).not_to eq(WeixinAuthorize::OK_CODE)
  end

  it "can get a weixin Menu info" do
    menu_info = $client.menu
    expect(menu_info.result.keys[0]).to eq("menu")
    expect(menu_info.code).to eq(WeixinAuthorize::OK_CODE)
  end

  it "can delete weixin Menu" do
    response = $client.delete_menu
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
  end
end
