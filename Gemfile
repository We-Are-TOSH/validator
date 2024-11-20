source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'http', '~> 4.4'
gem 'dotenv-rails'
gem 'whenever', require: false
gem 'sinatra'
gem 'factory_bot_rails'
gem 'apipie-rails'
gem 'encrypted_strings'
gem 'prometheus-client'
gem 'rack-attack'
gem 'groupdate'
gem 'chartkick'
gem 'sidekiq'
gem 'rails_admin', '~> 3.0'
gem 'sprockets-rails'
gem 'sass-rails'
gem 'jbuilder'
gem 'redis', '~> 4.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'devise'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'webmock'
end

group :development do
  gem 'spring'
end
