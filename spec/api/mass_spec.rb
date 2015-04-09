require "spec_helper"

describe WeixinAuthorize::Api::Mass do

  let(:image_jpg_path) do
    "#{File.dirname(__FILE__)}/medias/ruby-logo.jpg"
  end

  let(:news_media_1) do
    {
      "thumb_media_id" => "",
      "author" => "lanrion",
      "title"  => "Happy Day",
      "content_source_url" => "www.qq.com",
      "content" => "content",
      "digest"  => "digest"
    }
  end

  let(:image_media_id) do
    # Get image media_id
    image_media = $client.upload_media(image_jpg_path, "image")
    media_id    = image_media.result["media_id"]
    media_id
  end

  let(:mass_media_id) do
    media       = {"thumb_media_id" => image_media_id}
    news_media  = news_media_1.merge(media)

    # upload news media
    response = $client.upload_mass_news([news_media])
    mass_media_id = response.result["media_id"]
    mass_media_id
  end

  it "#upload_mass_news" do
    media       = {"thumb_media_id" => image_media_id}
    news_media  = news_media_1.merge(media)

    # upload news media
    response = $client.upload_mass_news([news_media])
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "#mass_with_group with mpnews" do
    response = $client.mass_with_group("1", "mass_group_text", "text")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
  end

  it "#mass_with_groug send to all" do
    response = $client.mass_with_group("1", "mass_group_text_to_all", "text", true)
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
  end

  it "#mass_with_openids with mpnews and can delete message" do
    response = $client.mass_with_openids([ENV["OPENID"]], mass_media_id)
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["msg_id"])
    delete_res = $client.mass_delete_with_msgid(response.result["msg_id"])
    expect(delete_res.code).to eq(WeixinAuthorize::OK_CODE)
  end

  it "#mass_preview can preview by openid" do
    response = $client.mass_preview(ENV["OPENID"], "mass_text", "text")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
  end

end
