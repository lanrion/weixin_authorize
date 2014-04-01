# WeixinAuthorize

[![Gem Version](https://badge.fury.io/rb/weixin_authorize.png)](http://badge.fury.io/rb/weixin_authorize)
[![Build Status](https://secure.travis-ci.org/lanrion/weixin_authorize.png?branch=master)](http://travis-ci.org/lanrion/weixin_authorize)
[![Code Climate](https://codeclimate.com/github/lanrion/weixin_authorize.png)](https://codeclimate.com/github/lanrion/weixin_authorize)

Support using [Redis](http://redis.io) to store `access_token`

[Getting-Started](https://github.com/lanrion/weixin_authorize/wiki/Getting-Started)

## How to test

Go to https://github.com/lanrion/weixin_authorize/issues/2, apply a weixin sandbox test account and follow this account, then add them to your `~/.bash_profile`

```
export APPID="your test account weixin app_id"
export APPSECRET="your test account weixin appsecret"
export OPENID="your weixin openid"
```
Last, you have to **open a new terminal tag (Reload bash_profile)** , and run `rspec .`

**微信API挺SB，客服消息API，如果出现45015（回复时间超过限制），那么需要取消关注测试账号，然后再重新关注一次即可。另外，创建用户分组API刚开始测试的时候是OK的，后来会出现-1（系统繁忙），然后一直是这样。**

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
