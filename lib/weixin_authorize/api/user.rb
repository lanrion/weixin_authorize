# encoding: utf-8
module WeixinAuthorize
  module Api
    module User

      # 获取用户基本信息
      # https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN
      # lang: zh_CN, zh_TW, en
      def user(openid, lang="zh_CN")
        user_info_url = "#{user_base_url}/info"
        http_get(user_info_url, {openid: openid, lang: lang})
      end

      # https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=NEXT_OPENID
      # 获取关注者列表
      def followers(next_openid=nil)
        followers_url = "#{user_base_url}/get"
        http_get(followers_url, {next_openid: next_openid})
      end

      private

        def user_base_url
          "/user"
        end

    end
  end
end
