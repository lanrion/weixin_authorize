# encoding: utf-8
module WeixinAuthorize
  module Api
    module Custom

      # 发送文本消息
      # {
      #     "touser":"OPENID",
      #     "msgtype":"text",
      #     "text":
      #     {
      #        "content":"Hello World"
      #     }
      # }
      def send_text_custom(to_user, content)
        message = default_options(to_user).merge({text: {content: content}})
        http_post(custom_base_url, message)
      end

      # 发送图片消息
      # {
      #     "touser":"OPENID",
      #     "msgtype":"image",
      #     "image":
      #     {
      #       "media_id":"MEDIA_ID"
      #     }
      # }
      def send_image_custom(to_user, media_id)
        message = default_options(to_user, "image").merge({image: {media_id: media_id}})
        http_post(custom_base_url, message)
      end

      # 发送语音消息
      # {
      #     "touser":"OPENID",
      #     "msgtype":"voice",
      #     "voice":
      #     {
      #       "media_id":"MEDIA_ID"
      #     }
      # }
      def send_voice_custom(to_user, media_id)
        message = default_options(to_user, "voice").merge({voice: {media_id: media_id}})
        http_post(custom_base_url, message)
      end

      # 发送视频消息
      # {
      #     "touser":"OPENID",
      #     "msgtype":"video",
      #     "video":
      #     {
      #       "media_id":"MEDIA_ID"
      #     }
      # }
      def send_video_custom(to_user, media_id, options={})
        video_options = {media_id: media_id}.merge(options)
        message = default_options(to_user, "video").merge({video: video_options})
        http_post(custom_base_url, message)
      end

      # 发送音乐消息
      # {
      #     "touser":"OPENID",
      #     "msgtype":"music",
      #     "music":
      #     {
      #      "title":"MUSIC_TITLE",
      #     "description":"MUSIC_DESCRIPTION",
      #      "musicurl":"MUSIC_URL",
      #     "hqmusicurl":"HQ_MUSIC_URL",
      #      "thumb_media_id":"THUMB_MEDIA_ID"
      #     }
      # }
      def send_music_custom(to_user, media_id, musicurl, hqmusicurl, options={})
        music_options = { thumb_media_id: media_id,
                          musicurl: musicurl,
                          hqmusicurl: hqmusicurl
                        }.merge(options)
        message = default_options(to_user, "music").merge({music: music_options})
        http_post(custom_base_url, message)
      end

      # 发送图文消息
      # {
      #     "touser":"OPENID",
      #     "msgtype":"news",
      #      "news":{
      #        "articles": [
      #         {
      #             "title":"Happy Day",
      #             "description":"Is Really A Happy Day",
      #             "url":"URL",
      #             "picurl":"PIC_URL"
      #         },
      #         {
      #             "title":"Happy Day",
      #             "description":"Is Really A Happy Day",
      #             "url":"URL",
      #             "picurl":"PIC_URL"
      #         }
      #         ]
      #    }
      # }
      def send_news_custom(to_user, articles=[])
        message = default_options(to_user, "news").merge({news: {articles: articles}})
        http_post(custom_base_url, message)
      end

      private

        # https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN
        def custom_base_url
          "/message/custom/send"
        end

        def default_options(to_user, msgtype="text")
          {touser: to_user, msgtype: msgtype}
        end

    end
  end
end
