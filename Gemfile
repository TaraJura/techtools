# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise'
gem 'dry-schema'
gem 'exception_notification'
gem 'hamlit'
gem 'image_processing', '>= 1.2'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'mysql2', '~> 0.5'
gem 'nokogiri'
gem 'pry-rails'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'rails-i18n'
gem 'redis'
gem 'ruby-openai'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'watir', '~> 7.2', '>= 7.2.2'
gem 'webdrivers'
gem 'mini_magick'

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
