# encoding: utf-8
module WeixinAuthorize
  module Api
    module Qrcode
    # http://mp.weixin.qq.com/wiki/index.php?title=生成带参数的二维码

      # 临时二维码
      def create_qr_scene(scene_id, expire_seconds=1800)
        qrcode_infos = {action_name: "QR_SCENE", expire_seconds: expire_seconds}
        qrcode_infos.merge!(action_info(scene_id))
        http_post(qrcode_base_url, qrcode_infos)
      end

      # 临时字符串参数二维码
      def create_qr_str_scene(options, expire_seconds=1800)
        scene_str = options[:scene_str]
        qrcode_infos = {action_name: "QR_STR_SCENE", expire_seconds: expire_seconds}
        qrcode_infos.merge!(action_info(nil, scene_str))
        http_post(qrcode_base_url, qrcode_infos)
      end


      # 永久二维码
      # options: scene_id, scene_str
      def create_qr_limit_scene(options)
        scene_id = options[:scene_id]
        qrcode_infos = {action_name: "QR_LIMIT_SCENE"}
        qrcode_infos.merge!(action_info(scene_id))
        http_post(qrcode_base_url, qrcode_infos)
      end

      # 为永久的字符串参数值
      # options: scene_str
      def create_qr_limit_str_scene(options)
        scene_str = options[:scene_str]
        qrcode_infos = {action_name: "QR_LIMIT_STR_SCENE"}
        qrcode_infos.merge!(action_info(nil, scene_str))
        http_post(qrcode_base_url, qrcode_infos)
      end


      # 通过ticket换取二维码, 直接访问即可显示！
      def qr_code_url(ticket)
        WeixinAuthorize.mp_endpoint("/showqrcode?ticket=#{ticket}")
      end

      private

        def qrcode_base_url
          "/qrcode/create"
        end

        def action_info(scene_id, scene_str=nil)
          scene_info = {}
          scene_info[:scene_id] = scene_id if !scene_id.nil?
          scene_info[:scene_str] = scene_str if !scene_str.nil?
          {action_info: {scene: scene_info}}
        end

    end
  end
end
