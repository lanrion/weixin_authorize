require "spec_helper"

describe WeixinAuthorize::Api::Media do

  let(:image_path) do
    "#{File.dirname(__FILE__)}/medias/ruby-logo.jpg"
  end

  let(:image_file) do
    File.new(image_path)
  end

  let(:remote_image_path) do
    "http://l.ruby-china.org/user/large_avatar/273.png"
    # "http://g.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=ce55457e4334970a537e187df4a3baad/03087bf40ad162d99455ef4d13dfa9ec8b13632762d0ed14.jpg"
  end

  it "can upload a image" do
    response = $client.upload_media(image_file, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "#download_media_url return a String url" do
    image = $client.upload_media(image_file, "image")
    media_id = image.result["media_id"]
    response = $client.download_media_url(media_id)
    expect(response.class).to eq(String)
  end

  it "can upload a remote image" do
    response = $client.upload_media(remote_image_path, "image", true)
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

end
