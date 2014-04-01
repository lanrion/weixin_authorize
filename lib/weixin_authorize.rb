require "rest-client"
require "multi_json"
require "weixin_authorize/config"
require "weixin_authorize/adapter"
require "weixin_authorize/api"
require "weixin_authorize/client"

module WeixinAuthorize

  class << self

    def http_get_without_token(url, headers={}, endpoint="plain")
      get_api_url = endpoint_url(endpoint, url)
      load_json(RestClient.get(get_api_url, :params => headers))
    end

    def http_post_without_token(url, payload={}, headers={}, endpoint="plain")
      post_api_url = endpoint_url(endpoint, url)
      payload = MultiJson.dump(payload) if endpoint == "plain" # to json if invoke "plain"
      load_json(RestClient.post(post_api_url, payload, headers))
    end

    # return hash
    def load_json(string)
      JSON.parse(string)
    end

    def endpoint_url(endpoint, url)
      send("#{endpoint}_endpoint") + url
    end

    def plain_endpoint
      "https://api.weixin.qq.com/cgi-bin"
    end

    def file_endpoint
      "http://file.api.weixin.qq.com/cgi-bin"
    end

    def mp_endpoint
      "https://mp.weixin.qq.com/cgi-bin"
    end

  end

end
