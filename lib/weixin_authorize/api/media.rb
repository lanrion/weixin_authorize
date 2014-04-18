# encoding: utf-8

module WeixinAuthorize
  module Api
    module Media
      # 上传多媒体文件
      # http请求方式: POST/FORM
      # http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE
      # 支持传路径或者文件类型
      def upload_media(media, media_type, remote=false)
        file = process_file(media, remote)
        upload_media_url = "#{media_base_url}/upload"
        http_post(upload_media_url, {media: file}, {type: media_type}, "file")
      end

      # 目前仅仅把下载链接返回给第三方开发者，由第三方开发者处理下载
      def download_media_url(media_id)
        download_media_url = WeixinAuthorize.endpoint_url("file", "#{media_base_url}/get")
        params = URI.encode_www_form("access_token" => get_access_token,
                                     "media_id"     => media_id)
        download_media_url += "?#{params}"
        download_media_url
      end

      private

        def process_file(media, remote)
          if remote
            base = WeixinUploader.new
            base.download!(media.to_s)
            base.file.to_file
            # CarrierWave.clean_cached_files!
          else
           media.is_a?(File) ? media : File.new(media)
          end
        end

        def media_base_url
          "/media"
        end
    end
  end
end
