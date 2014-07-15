# encoding: utf-8
module WeixinAuthorize
  module Api
    module Oauth

      # 应用授权作用域: scope
      # snsapi_base （不弹出授权页面，直接跳转，只能获取用户openid），
      # snsapi_userinfo （弹出授权页面，可通过openid拿到昵称、性别、所在地。并且，即使在未关注的情况下，只要用户授权，也能获取其信息）
      # default is snsapi_base
      # state 重定向后会带上state参数，开发者可以填写a-zA-Z0-9的参数值

      # 如果用户点击同意授权，页面将跳转至 redirect_uri/?code=CODE&state=STATE。若用户禁止授权，则重定向后不会带上code参数，仅会带上state参数redirect_uri?state=STATE
      def authorize_url(redirect_uri, scope="snsapi_base", state="")
        require "erb"
        ERB::Util.url_encode(WeixinAuthorize.open_endpoint("/connect/oauth2/authorize?appid=#{app_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}&state=#{state}#wechat_redirect"))
      end

      # 首先请注意，这里通过code换取的网页授权access_token,与基础支持中的access_token不同。公众号可通过下述接口来获取网页授权access_token。如果网页授权的作用域为snsapi_base，则本步骤中获取到网页授权access_token的同时，也获取到了openid，snsapi_base式的网页授权流程即到此为止。

      # 微信通过请求 #authorize_url 方法后，会返回一个code到redirect_uri中
      def get_oauth_access_token(code)
        http_get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{app_id}&secret=#{app_secret}&code=#{code}&grant_type=authorization_code")
      end

      private


    end
  end
end