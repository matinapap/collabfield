source "https://rubygems.org"

# Rails version
gem "rails", "~> 8.0.1"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Gems for the database and essential libraries
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# Gems for development and testing
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "dotenv-rails"

# Bootstrap and related gems
gem 'bootstrap', '~> 5.0.0'
gem 'sassc-rails', '>= 2.1.2'
gem 'jquery-rails'
gem 'bootstrap_form'

# Authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2' # For Google
gem 'omniauth-facebook' # For Facebook
gem 'omniauth-twitter' # For Twitter

# Testing gems
gem 'rspec-rails', '~> 7.1'
gem 'rails-controller-testing'
gem 'database_cleaner-active_record', '~> 2.0'

# Browser automation
gem 'selenium-webdriver'
gem 'capybara', '~> 3.35'
gem 'cuprite' # For headless browser testing
gem 'will_paginate', '~> 3.1.0'

gem 'faker'
gem 'pagy'
gem 'kaminari'


group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem 'factory_bot_rails'
end
