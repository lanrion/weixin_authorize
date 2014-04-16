module WeixinAuthorize

  class WeixinUploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick
    # 微信只支持jpg格式,目前还有bug.
    process :convert => 'jpg'
  end

end
