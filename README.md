# WeixinAuthorize

[![Gem Version](https://badge.fury.io/rb/weixin_authorize.png)](http://badge.fury.io/rb/weixin_authorize)

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
