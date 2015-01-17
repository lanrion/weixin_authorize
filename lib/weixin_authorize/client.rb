# encoding: utf-8
require "redis"
require 'digest/md5'
module WeixinAuthorize

  class Client
    include Api::User
    include Api::Menu
    include Api::Custom
    include Api::Groups
    include Api::Qrcode
    include Api::Media
    include Api::Oauth
    include Api::Template

    attr_accessor :app_id, :app_secret, :expired_at # Time.now + expires_in
    attr_accessor :access_token, :redis_key
    attr_accessor :storage, :jsticket

    def initialize(app_id, app_secret, redis_key=nil)
      @app_id     = app_id
      @app_secret = app_secret
      @expired_at = Time.now.to_i
      @redis_key  = security_redis_key((redis_key || "weixin_" + app_id))
      @storage    = Storage.init_with(self)
    end

    # return token
    def get_access_token
      @storage.access_token
    end

    # 检查appid和app_secret是否有效。
    def is_valid?
      @storage.valid?
    end

    # TODO: refactor with difference storage
    def js_ticket
      raise ValidAccessTokenException if !is_valid?
      if @jsticket.nil? || @jsticket.result["expired_at"] <= Time.now.to_i
        @jsticket ||= get_jsticket
      end
      @jsticket.result["ticket"]
    end

    # 获取js sdk 签名包
    def get_jssign_package(url)
      timestamp = Time.now.to_i
      noncestr = SecureRandom.hex(16)
      string = {
        jsapi_ticket: js_ticket,
        noncestr: noncestr,
        timestamp: timestamp,
        url: url
      }.to_param

      signature = Digest::SHA1.hexdigest(string)
      {
        "appId"     => app_id,    "nonceStr"  => noncestr,
        "timestamp" => timestamp, "url"       => url,
        "signature" => signature, "rawString" => string
      }
    end

    private

      def get_jsticket
        ticket = http_get("/ticket/getticket", {type: 1})
        ticket.result["expired_at"] = ticket.result["expires_in"] + Time.now.to_i
        ticket
      end

      def access_token_param
        {access_token: get_access_token}
      end

      def http_get(url, headers={}, endpoint="plain")
        puts "get jsticket" if url.include?("getticket")
        headers = headers.merge(access_token_param)
        WeixinAuthorize.http_get_without_token(url, headers, endpoint)
      end

      def http_post(url, payload={}, headers={}, endpoint="plain")
        headers = access_token_param.merge(headers)
        WeixinAuthorize.http_post_without_token(url, payload, headers, endpoint)
      end

      def security_redis_key(key)
        Digest::MD5.hexdigest(key.to_s).upcase
      end

  end
end
