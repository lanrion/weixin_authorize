# encoding: utf-8

module WeixinAuthorize
  module Api
    module Media
      # 上传多媒体文件
      # http请求方式: POST/FORM
      # http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE
      # 支持传路径或者文件类型
      def upload_media(media, media_type)
        file = process_file(media)
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

      # 上传图文消息素材, 主要用于群发消息接口
      # {
      #    "articles": [
      #      {
      #        "thumb_media_id":"mwvBelOXCFZiq2OsIU-p",
      #        "author":"xxx",
      #        "title":"Happy Day",
      #        "content_source_url":"www.qq.com",
      #        "content":"content",
      #        "digest":"digest"
      #      },
      #      {
      #        "thumb_media_id":"mwvBelOXCFZiq2OsIU-p",
      #        "author":"xxx",
      #        "title":"Happy Day",
      #        "content_source_url":"www.qq.com",
      #        "content":"content",
      #        "digest":"digest"
      #      }
      #    ]
      # }
      # Option: author, content_source_url
      def upload_mass_news(news=[])
        upload_news_url = "#{media_base_url}/uploadnews"
        http_post(upload_news_url, {articles: news})
      end

      # media_id: 需通过基础支持中的上传下载多媒体文件来得到
      # https://file.api.weixin.qq.com/cgi-bin/media/uploadvideo?access_token=ACCESS_TOKEN

      # return:
      # {
      #   "type":"video",
      #   "media_id":"IhdaAQXuvJtGzwwc0abfXnzeezfO0NgPK6AQYShD8RQYMTtfzbLdBIQkQziv2XJc",
      #   "created_at":1398848981
      # }
      def upload_mass_video(media_id, title="", desc="")
        video_msg = {
          "media_id"    => media_id,
          "title"       => title,
          "description" => desc
        }

        http_post("#{media_base_url}/uploadvideo", video_msg)
      end

      # 上传图文消息内的图片获取URL
      # https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=ACCESS_TOKEN
      #
      # return:
      # {
      #   "url":  "http://mmbiz.qpic.cn/mmbiz/gLO17UPS6FS2xsypf378iaNhWacZ1G1UplZYWEYfwvuU6Ont96b1roYs CNFwaRrSaKTPCUdBK9DgEHicsKwWCBRQ/0"
      # }
      def upload_image(image)
        file = process_file(image)
        upload_image_url = "#{media_base_url}/uploadimg"
        http_post(upload_image_url, {media: file}, {type: 'image'}, 'file')
      end

      private

        def media_base_url
          "/media"
        end

        def process_file(media)
          return media if media.is_a?(File) && jpep?(media)

          media_url = media
          uploader  = WeixinUploader.new

          if http?(media_url) # remote
            uploader.download!(media_url.to_s)
          else # local
            media_file = media.is_a?(File) ? media : File.new(media_url)
            uploader.cache!(media_file)
          end
          file = process_media(uploader)
          CarrierWave.clean_cached_files! # clear last one day cache
          file
        end

        def process_media(uploader)
          uploader = covert(uploader)
          uploader.file.to_file
        end

        # JUST ONLY FOR JPG IMAGE
        def covert(uploader)
          # image process
          unless (uploader.file.content_type =~ /image/).nil?
            if !jpep?(uploader.file)
              require "mini_magick"
              # covert to jpeg
              image = MiniMagick::Image.open(uploader.path)
              image.format("jpg")
              uploader.cache!(File.open(image.path))
              image.destroy! # remove /tmp from MinMagick generate
            end
          end
          uploader
        end

        def http?(uri)
          return false if !uri.is_a?(String)
          uri = URI.parse(uri)
          uri.scheme =~ /^https?$/
        end

        def jpep?(file)
          content_type = if file.respond_to?(:content_type)
              file.content_type
            else
              content_type(file.path)
            end
          !(content_type =~ /jpeg/).nil?
        end

        def content_type(media_path)
          MIME::Types.type_for(media_path).first.content_type
        end

    end
  end
end
