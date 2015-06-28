# encoding: utf-8
module WeixinAuthorize
  module Api
    module Groups

      # 创建分组
      # https://api.weixin.qq.com/cgi-bin/groups/create?access_token=ACCESS_TOKEN
      def create_group(group_name)
        create_url = "#{group_base_url}/create"
        http_post(create_url, {group: {name: group_name}})
      end

      # 查询所有分组
      # https://api.weixin.qq.com/cgi-bin/groups/get?access_token=ACCESS_TOKEN
      def groups
        groups_url = "#{group_base_url}/get"
        http_get(groups_url)
      end

      # 查询用户所在分组
      # https://api.weixin.qq.com/cgi-bin/groups/getid?access_token=ACCESS_TOKEN
      def get_group_for(openid)
        group_url = "#{group_base_url}/getid"
        http_post(group_url, {openid: openid})
      end

      # 修改分组名
      # https://api.weixin.qq.com/cgi-bin/groups/update?access_token=ACCESS_TOKEN
      def update_group_name(group_id, new_group_name)
        group_url = "#{group_base_url}/update"
        http_post(group_url, {group: {id: group_id, name: new_group_name}})
      end

      # 移动用户分组
      # https://api.weixin.qq.com/cgi-bin/groups/members/update?access_token=ACCESS_TOKEN
      def update_group_for_openid(openid, to_groupid)
        group_url = "#{group_base_url}/members/update"
        http_post(group_url, {openid: openid, to_groupid: to_groupid})
      end

      # 批量移动用户分组
      def batch_update_group_for_openids(openids, group_id)
        group_url = "#{group_base_url}/members/batchupdate"
        http_post(group_url, {openid_list: openids, to_groupid: group_id})
      end

      def delete_group(group_id)
        group_url = "#{group_base_url}/delete"
        http_post(group_url, {group: {id: group_id}})
      end

      private

        def group_base_url
          "/groups"
        end

    end
  end
end
