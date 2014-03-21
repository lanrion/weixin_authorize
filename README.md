# WeixinAuthorize

Support using [Redis](http://redis.io) to store `access_token`

## Installation

Add this line to your application's Gemfile:

  `gem 'weixin_authorize'`

  Or

  `gem 'weixin_authorize', git: "https://github.com/lanrion/weixin_authorize.git"`

And then execute:

  `$ bundle`

Or install it yourself as:

  `$ gem install weixin_authorize`

## Usage

### Init a `client`

```ruby

$client ||= WeixinAuthorize::Client.new(ENV["APPID"], ENV["APPSECRET"])
```

### Option: use [Redis](http://redis.io) to store your access_token (Recommend)

  **If you don't use Redis, it will send a request to get a new access_token everytime!**

* Create file in: `config/initializers/weixin_authorize.rb`

  ```ruby

  # don't forget change namespace
  namespace = "app_name_weixin:weixin_authorize"
  redis = Redis.new(:host => "127.0.0.1", :port => "6379", :db => 15)

  # cleanup keys in the current namespace when restart server everytime.
  exist_keys = redis.keys("#{namespace}:*")
  exist_keys.each{|key|redis.del(key)}

  # Give a special namespace as prefix for Redis key, when your have more than one project used weixin_authorize, this config will make them work fine.
  redis = Redis::Namespace.new("#{namespace}", :redis => redis)

  WeixinAuthorize.configure do |config|
    config.redis = redis
  end

  ```

* You can also specify the `key`, but it is optionly.

  ```ruby

  $client ||= WeixinAuthorize::Client.new(ENV["APPID"], ENV["APPSECRET"], "your_store_key")
  ```
  **Note:** `your_store_key` should be unique for every account!

### 获取用户管理信息

* [获取用户基本信息](http://mp.weixin.qq.com/wiki/index.php?title=获取用户基本信息)

  `user_info = $client.user(ENV["OPENID"])`

* [获取关注者列表](http://mp.weixin.qq.com/wiki/index.php?title=获取关注者列表)

  `followers = $client.followers`

### [分组管理接口](http://mp.weixin.qq.com/wiki/index.php?title=分组管理接口)

* 创建分组:

  `group = $client.create_group("test")`

* 查询所有分组:

  `groups = $client.groups`
* 查询用户所在分组:

  `group = $client.get_group_for(ENV["OPENID"])`

* 修改分组名:

  `group = $client.update_group_name(ENV["OPENID"], "new_group_name")`

* 移动用户分组:

  `group = $client.update_group_for_openid(ENV["OPENID"], "to_groupid")`

### 自定义菜单

* [自定义菜单创建接口](http://mp.weixin.qq.com/wiki/index.php?title=自定义菜单创建接口)

  `response = $client.create_menu(menu) # Hash or Json`

* [自定义菜单查询接口](http://mp.weixin.qq.com/wiki/index.php?title=自定义菜单查询接口)

  `response = $client.menu`

* [自定义菜单删除接口](http://mp.weixin.qq.com/wiki/index.php?title=自定义菜单删除接口)

  `response = $client.delete_menu`

### [发送客服信息](http://mp.weixin.qq.com/wiki/index.php?title=发送客服信息)

* 发送文本信息:

  `$client.send_text_custom(to_user, content)`

* 发送图片信息:

  `$client.send_image_custom(to_user, media_id)`

* 发送语音消息:

  `$client.send_voice_custom(to_user, media_id)`

* 发送视频消息:

  `$client.send_video_custom(to_user, media_id, options)`

* 发送音乐消息:

  `$client.send_music_custom(to_user, media_id, musicurl, hqmusicurl, options)`

* 发送图文消息:

  `$client.send_news_custom(to_user, *articles)`

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
