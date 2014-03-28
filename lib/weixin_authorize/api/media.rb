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


      # http://www.cnblogs.com/txw1958/p/weixin80-upload-download-media-file.html
      def download_media(media_id)
        download_media_url = "#{media_base_url}/get"
        http_download(download_media_url, {media_id: media_id})
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

        def http_download(url, options={})
          options = options.merge(access_token_param)
          download_url = file_endpoint + url
          RestClient.get(download_url, :params => options)
        end

    end
  end
end
