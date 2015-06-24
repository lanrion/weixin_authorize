require "rest-client"
require "carrierwave"
if defined? Yajl
  require 'yajl/json_gem'
else
  require "json"
end

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

  OK_MSG  = "ok"
  OK_CODE = 0
  GRANT_TYPE = "client_credential"

  class << self

    def http_get_without_token(url, headers={}, endpoint="plain")
      get_api_url = endpoint_url(endpoint, url)
      load_json(resource(get_api_url).get(params: headers))
    end

    def http_post_without_token(url, payload={}, headers={}, endpoint="plain")
      post_api_url = endpoint_url(endpoint, url)
      payload = JSON.dump(payload) if endpoint == "plain" # to json if invoke "plain"
      load_json(resource(post_api_url).post(payload, params: headers))
    end

    def resource(url)
      RestClient::Resource.new(url, rest_client_options)
    end

    # return hash
    def load_json(string)
      result_hash = JSON.parse(string)
      code   = result_hash.delete("errcode")
      en_msg = result_hash.delete("errmsg")
      ResultHandler.new(code, en_msg, result_hash)
    end

    def endpoint_url(endpoint, url)
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
