# WeixinAuthorize

1, 获取access_token: https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET

2, 上传多媒体文件

http请求方式: POST/FORM
http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE
调用示例（使用curl命令，用FORM表单方式上传一个多媒体文件）：
curl -F media=@test.jpg "http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE"

3, 发送客服消息

http请求方式: POST
https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN

4, 获取用户基本信息

http请求方式: GET
https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN

5, 获取关注者列表

http请求方式: GET（请使用https协议）
https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=NEXT_OPENID


## Installation

Add this line to your application's Gemfile:

    gem 'weixin_authorize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weixin_authorize

## Usage



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
