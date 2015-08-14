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

      # 官方示例：{endtime: 1439571890, pageindex: 1, pagesize: 10, starttime: 1438707864}
      # options:
      # page_index: 查询第几页，从1开始
      # page_size: 每页大小，每页最多拉取50条
      CUSTOM_RECORD_URL = "https://api.weixin.qq.com/customservice/msgrecord/getrecord".freeze
      def get_custom_msg_record(start_time, end_time, options={})
        start_time, end_time = start_time.to_i, end_time.to_i
        page_index = options[:page_index] || 1
        page_size  = options[:page_size]  || 50
        option = {
          endtime: end_time,
          starttime: start_time,
          pageindex: page_index,
          pagesize: page_size
        }
        http_post(CUSTOM_RECORD_URL, option, {}, WeixinAuthorize::CUSTOM_ENDPOINT)
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
