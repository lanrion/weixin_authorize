require "weixin_authorize/version"

module WeixinAuthorize

  # @client ||= WeixinAuthorize.configure do |config|
  #               config.app_id     = "app_id-xxxxxxx"
  #               config.app_secret = "app_secret-xxxxxxx"
  #             end
  #
  class << self
    def configure(&block)
      Client.new(&block)
    end
  end

end
