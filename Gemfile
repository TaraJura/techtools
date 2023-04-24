# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

gem 'image_processing', '>= 1.2'

gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

gem 'sprockets-rails'

gem 'mysql2', '~> 0.5'

gem 'puma', '~> 5.0'

gem 'jsbundling-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'cssbundling-rails'

gem 'jbuilder'

gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'haml_lint', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'simplecov', require: false
end
gem 'dry-schema'
gem 'exception_notification'
gem 'hamlit'
gem 'pry-rails'
gem 'rails-i18n'
