require "spec_helper"

describe WeixinAuthorize::Api::Media do

  let(:image_jpg_path) do
    "#{File.dirname(__FILE__)}/medias/ruby-logo.jpg"
  end

  let(:image_ico_path) do
    "#{File.dirname(__FILE__)}/medias/favicon.ico"
  end

  let(:image_jpg_file) do
    File.new(image_jpg_path)
  end

  let(:image_ico_file) do
    File.new(image_ico_path)
  end

  let(:remote_png_path) do
    "https://ruby-china-files.b0.upaiyun.com/user/big_avatar/273.jpg"
  end

  let(:remote_jpg_path) do
    "http://g.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=ce55457e4334970a537e187df4a3baad/03087bf40ad162d99455ef4d13dfa9ec8b13632762d0ed14.jpg"
  end

  it "can upload a jpg File image" do
    response = $client.upload_media(image_jpg_file, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a ico File image" do
    response = $client.upload_media(image_ico_file, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a local image" do
    response = $client.upload_media(image_jpg_path, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a local ico image" do
    response = $client.upload_media(image_ico_path, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a remote png image" do
    response = $client.upload_media(remote_png_path, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "can upload a remote jpg image" do
    response = $client.upload_media(remote_jpg_path, "image")
    expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    expect(response.result.keys).to eq(["type", "media_id", "created_at"])
  end

  it "#download_media_url return a String url" do
    image = $client.upload_media(image_ico_path, "image")
    media_id = image.result["media_id"]
    image_url = $client.download_media_url(media_id)
    expect(image_url.class).to eq(String)
  end

end
