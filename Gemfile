source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.1'
gem 'mysql2'
gem 'active_model_serializers', '0.8.1'
# broken 2.12.0 release
gem 'puma', require: false
gem 'unicorn'
gem 'will_paginate'
gem 'carrierwave'
gem 'mini_magick'
gem 'ransack'
group :development, :test, :production do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'byebug'
  gem 'faker'
end

group :development do
  gem 'annotate'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-nginx-unicorn'
end

group :test do
  gem 'childprocess', '0.3.6'
  gem 'spork', '1.0.0rc4'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'fuubar'
  gem 'capybara', '~> 2.1'
  gem 'selenium-webdriver'
  gem 'connection_pool'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-fsevent', require: false
  gem 'growl', '~> 1.0.3'
  gem 'webmock'
end
gem 'rvm-capistrano'