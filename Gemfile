source 'https://rubygems.org'

group :test do
  gem "rspec", "~> 3.0.0.beta1"
  gem "redis-namespace", "~> 1.4.1"
  if ENV["CI"]
    gem "codeclimate-test-reporter", require: nil
    gem 'coveralls', require: false
  end
end

# Specify your gem's dependencies in weixin_authorize.gemspec
gemspec

