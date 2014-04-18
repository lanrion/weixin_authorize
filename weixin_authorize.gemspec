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
  spec.add_dependency "redis", "~> 3.0.7"
  # A streaming JSON parsing and encoding library for Ruby (C bindings to yajl)
  # https://github.com/brianmario/yajl-ruby
  spec.add_dependency "yajl-ruby", "~> 1.2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

end
