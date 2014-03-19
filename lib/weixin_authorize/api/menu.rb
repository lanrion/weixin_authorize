# encoding: utf-8
module WeixinAuthorize
  module Api
    module Menu

      # 自定义菜单查询接口
      # https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN
      def menu
        get_menu_url = "#{menu_base_url}/get"
        http_get(get_menu_url)
      end

      # 自定义菜单删除接口
      # https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN
      def delete_menu
        delete_menu_url = "#{menu_base_url}/delete"
        http_get(delete_menu_url)
      end

      # 自定义菜单创建接口
      # https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN
      def create_menu(menu)
        menu = MultiJson.load(menu) if menu.is_a?(String)
        create_menu_url = "#{menu_base_url}/create"
        http_post(create_menu_url, menu)
      end

      private

        def menu_base_url
          "/menu"
        end

    end
  end
end
