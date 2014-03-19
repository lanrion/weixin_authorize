# encoding: utf-8
require "spec_helper"

describe WeixinAuthorize::Api::Menu do

  it "can create a menu" do
    menu = '{"button":[{"type":"click","name":"今日歌曲","key":"V1001_TODAY_MUSIC"},{"type":"click","name":"歌手简介","key":"V1001_TODAY_SINGER"},{"name":"菜单","sub_button":[{"type":"view","name":"搜索","url":"http://www.soso.com/"},{"type":"view","name":"视频","url":"http://v.qq.com/"},{"type":"click","name":"赞一下我们","key":"V1001_GOOD"}]}]}'
    response = $client.create_menu(MultiJson.load(menu)) # or Json string
    expect(response["errcode"]).to eq(0)
  end

  it "can get a weixin Menu info" do
    menu_info = $client.menu
    expect(menu_info.keys[0]).to eq("menu")
  end

  it "can delete weixin Menu" do
    response = $client.delete_menu
    expect(response["errcode"]).to eq(0)
  end
end
