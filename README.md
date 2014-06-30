# WeixinAuthorize

[![Gem Version](https://badge.fury.io/rb/weixin_authorize.png)](http://badge.fury.io/rb/weixin_authorize)
[![Build Status](https://secure.travis-ci.org/lanrion/weixin_authorize.png?branch=master)](http://travis-ci.org/lanrion/weixin_authorize)
[![Code Climate](https://codeclimate.com/github/lanrion/weixin_authorize.png)](https://codeclimate.com/github/lanrion/weixin_authorize)
[![Coverage Status](https://codeclimate.com/github/lanrion/weixin_authorize/coverage.png)](https://codeclimate.com/github/lanrion/weixin_authorize)

Support using [Redis](http://redis.io) to store `access_token`

[Wiki](https://github.com/lanrion/weixin_authorize/wiki)

[Getting-Started](https://github.com/lanrion/weixin_authorize/wiki/Getting-Started)

注意：查看Wiki或者源代码时，请切换对应的版本来查看。Master处于不断更新完善分支。

## How to test

Go to https://github.com/lanrion/weixin_authorize/issues/2, apply a weixin sandbox test account and follow this account

https://github.com/lanrion/weixin_authorize/blob/master/spec/spec_helper.rb

change your infos: 

```ruby
ENV["APPID"]="wxe371e0960de5426a"
ENV["APPSECRET"]="572b93d3d20aea242692a804243a141b"
ENV["OPENID"]="oEEoyuEasxionjR5HygmEOQGwRcw"
```

then run `rspec .`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
