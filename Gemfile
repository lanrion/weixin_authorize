source 'https://rubygems.org'

group :test, :development do
  gem "rspec", "~> 3.0.0.beta1"
  gem "redis-namespace", "~> 1.4.1"
end

group :test do
  gem "rake", "~> 0.9.6"
  gem 'simplecov', '~> 0.7.1', :require => false
  gem "codeclimate-test-reporter", require: nil
  gem 'coveralls', require: false
end

group :development do
  # For debugger
  gem "pry-rails", "~> 0.3.2"

  gem "pry-debugger", "~> 0.2.2"
end

# Specify your gem's dependencies in weixin_authorize.gemspec
gemspec

