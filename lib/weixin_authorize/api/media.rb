# encoding: utf-8
module WeixinAuthorize
  module Api
    module Media

      # 上传多媒体文件
      # http请求方式: POST/FORM
      # http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE
      # 支持传路径或者文件类型
      def upload_media(media, type)
        file = media.is_a?(File) ? media : File.new(media)
        upload_media_url = "#{media_base_url}/upload"
        http_upload(upload_media_url, {media: file, media_type: type})
      end

      # 目前仅仅把下载链接返回给第三方开发者，由第三方开发者处理下载
      # php重新写入文件方式：
      # http://www.cnblogs.com/txw1958/p/weixin80-upload-download-media-file.html
      def download_media_url(media_id)
        download_media_url = file_endpoint + "#{media_base_url}/get"
        download_media_url += "?access_token=#{get_access_token}"
        download_media_url += "&media_id=#{media_id}"
        download_media_url
      end

      private

        def media_base_url
          "/media"
        end

        def http_upload(url, options)
          media_type = options.delete(:media_type)
          upload_url = file_endpoint + url
          upload_url += "?access_token=#{get_access_token}"
          upload_url += "&type=#{media_type}"
          JSON.parse(RestClient.post(upload_url, options))
        end

    end
  end
end
