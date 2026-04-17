# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 8.1.3'
gem 'propshaft'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'inertia_rails', '~> 3.19'
gem 'vite_rails', '~> 3.10'
gem 'rodauth-rails', '~> 2.1'
gem 'sequel', '~> 5'
gem 'sequel-activerecord_connection', '~> 2.0', require: false
gem 'bcrypt', '~> 3.1', require: false
gem 'tilt', '~> 2.4', require: false

gem 'tzinfo-data', platforms: %i[ windows jruby ]

gem 'solid_cache'
gem 'solid_queue'
gem 'solid_cable'

gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'thruster', require: false
gem 'image_processing', '~> 1.2'
gem 'pundit', '~> 2.5'

group :development, :test do
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false
  gem 'rubocop-rails-omakase', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop', '~> 1.82', require: false
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
