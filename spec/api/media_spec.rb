require "spec_helper"

describe WeixinAuthorize::Api::Media do

  let(:image_path) do
    "#{File.dirname(__FILE__)}/medias/ruby-logo.jpg"
  end

  let(:image_file) do
    File.new(image_path)
  end

  it "can upload a image" do
    response = $client.upload_media(image_file, "image")
    expect(response.keys).to eq(["type", "media_id", "created_at"])
  end

  it "#download_media" do
    image = $client.upload_media(image_file, "image")
    media_id = image["media_id"]
    response = $client.download_media(media_id)
    binding.pry
    expect(response.raw_headers.keys).to eq(["server",
                                             "date",
                                             "content-type",
                                             "connection",
                                             "content-disposition",
                                             "cache-control",
                                             "content-length"])
  end

end
