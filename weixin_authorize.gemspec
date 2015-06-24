# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weixin_authorize/version'

Gem::Specification.new do |spec|
  spec.name          = "weixin_authorize"
  spec.version       = WeixinAuthorize::VERSION
  spec.authors       = ["lanrion"]
  spec.email         = ["huaitao-deng@foxmail.com"]
  spec.description   = %q{weixin api authorize access_token}
  spec.summary       = %q{weixin api authorize access_token}
  spec.homepage      = "https://github.com/lanrion/weixin_authorize"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", ">= 1.6.7"
  spec.add_dependency "redis", ">= 3.1.0"

  spec.add_dependency "carrierwave", ">= 0.10.0"
  spec.add_dependency 'mini_magick', '>= 3.7.0'

  # A streaming JSON parsing and encoding library for Ruby (C bindings to yajl)
  # https://github.com/brianmario/yajl-ruby
  # yajl-ruby 不支持 jruby
  if RUBY_PLATFORM == 'java'
    spec.add_dependency "json"
  else
    spec.add_dependency "yajl-ruby", ">= 1.2.0"
  end

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "redis-namespace"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "simplecov", "~> 0.10.0"
  spec.add_development_dependency 'coveralls', '~> 0.8.2'
  spec.add_development_dependency 'pry-rails'
  if RUBY_PLATFORM != 'java'
    spec.add_development_dependency 'pry-byebug'
  end

end
