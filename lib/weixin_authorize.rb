require "rest-client"
require "carrierwave"
if defined? Yajl
  require 'yajl/json_gem'
else
  require "json"
end
require "erb"

require "weixin_authorize/carrierwave/weixin_uploader"
require "weixin_authorize/config"
require "weixin_authorize/handler"
require "weixin_authorize/api"
require "weixin_authorize/client"

module WeixinAuthorize

  # token store
  module Token
    autoload(:Store,       "weixin_authorize/token/store")
    autoload(:ObjectStore, "weixin_authorize/token/object_store")
    autoload(:RedisStore,  "weixin_authorize/token/redis_store")
  end

  module JsTicket
    autoload(:Store,       "weixin_authorize/js_ticket/store")
    autoload(:ObjectStore, "weixin_authorize/js_ticket/object_store")
    autoload(:RedisStore,  "weixin_authorize/js_ticket/redis_store")
  end

  OK_MSG  = "ok".freeze
  OK_CODE = 0.freeze
  GRANT_TYPE = "client_credential".freeze
  # 用于标记endpoint可以直接使用url作为完整请求API
  CUSTOM_ENDPOINT = "custom_endpoint".freeze

  class << self

    def http_get_without_token(url, url_params={}, endpoint="plain")
      get_api_url = endpoint_url(endpoint, url)
      load_json(resource(get_api_url).get(params: url_params))
    end

    def http_post_without_token(url, post_body={}, url_params={}, endpoint="plain")
      post_api_url = endpoint_url(endpoint, url)
      # to json if invoke "plain"
      if endpoint == "plain" || endpoint == CUSTOM_ENDPOINT
        post_body = JSON.dump(post_body)
      end
      load_json(resource(post_api_url).post(post_body, params: url_params))
    end

    def resource(url)
      RestClient::Resource.new(url, rest_client_options)
    end

    # return hash
    def load_json(string)
      result_hash = JSON.parse(string.force_encoding("UTF-8").gsub(/[\u0011-\u001F]/, ""))
      code   = result_hash.delete("errcode")
      en_msg = result_hash.delete("errmsg")
      ResultHandler.new(code, en_msg, result_hash)
    end

    def endpoint_url(endpoint, url)
      # 此处为了应对第三方开发者如果自助对接接口时，URL不规范的情况下，可以直接使用URL当为endpoint
      return url if endpoint == CUSTOM_ENDPOINT
      send("#{endpoint}_endpoint") + url
    end

    def plain_endpoint
      "#{api_endpoint}/cgi-bin"
    end

    def api_endpoint
      "https://api.weixin.qq.com"
    end

    def file_endpoint
      "http://file.api.weixin.qq.com/cgi-bin"
    end

    def mp_endpoint(url)
      "https://mp.weixin.qq.com/cgi-bin#{url}"
    end

    def open_endpoint(url)
      "https://open.weixin.qq.com#{url}"
    end

  end

end
