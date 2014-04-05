# encoding: utf-8

module WeixinAuthorize

  class ResultHandler
    attr_accessor :code, :cn_msg, :en_msg, :result

    def initialize(code=nil, en_msg=nil, result={})
      @code   = code   || 0
      @en_msg = en_msg || "ok"
      @cn_msg = GLOBAL_CODES[@code.to_i]
      @result = package_result(result)
    end

    private

      # if define Rails constant
      # result = WeixinAuthorize::ResultHandler.new("0", "success", {:ok => "true"})
      # result.result["ok"] #=> true
      # result.result[:ok] #=> true
      # result.result['ok'] #=> true
      def package_result(result)
        if defined?(Rails)
          ActiveSupport::HashWithIndifferentAccess.new(result)
        else
          result
        end
      end

  end

end
