describe WeixinAuthorize::Api::Template do
  # {{first.DATA}}
  # 项目名称：{{class.DATA}}
  # 时间：{{time.DATA}}
  # 地点：{{add.DATA}}
  # {{remark.DATA}}
  it "can send template msg" do
    url = "http://www.baidu.com"
    data = {
      first: {
        value: "报名结果通知",
        color: "#173277"
      },
      class: {
        value: "领导与管理课程培训/人格测评",
        color: "#173177"
      },
      time: {
        value: "11月6日—11月7日（周三—周五)",
        color: "#274177"
      },
      add: {
        value: "F302室",
        color: "#274377"
      },
      remark: {
        value: "您可点击【详情】查看详细信息。",
        color: "#274377"
      }
    }
    msg_result = $client.send_template_msg(
      ENV["OPENID"],
      ENV["TEMPLATE_ID"],
      url,
      "#173177",
      data
    )
    expect(msg_result.code).to eq(WeixinAuthorize::OK_CODE)
  end
end
