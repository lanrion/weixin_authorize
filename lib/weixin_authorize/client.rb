module WeixinAuthorize

  class Client
    attr_accessor :app_id, :app_secret

    attr_accessor :access_token

    def initialize(&block)
      instance_eval(&block)
    end

  end
end
