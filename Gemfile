# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

gem "rack", ">= 2.2.6.4"

gem "actionpack-action_caching"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Passenger web server
gem "passenger"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
end

group :development do
  gem "annotate"
  gem "erb_lint", require: false
  gem "overcommit", "~> 0.60.0"
  gem "rspec-rails"
  gem "rubocop-capybara", "~> 2.17"
  gem "rubocop-performance", "~> 1.17"
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", "~> 2.19"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cucumber"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "puma"
  gem "selenium-webdriver"
  gem "simplecov", require: false
end

gem "bcrypt", "~> 3.1"

gem "anki_record", "~> 0.4.1"

gem "whenever", require: false

gem "text", "~> 1.3"

gem "foreman", "~> 0.87.2"
