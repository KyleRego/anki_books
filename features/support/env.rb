# frozen_string_literal: true

require "pry"

require "cucumber/rails"
require "capybara/cucumber"
require "selenium-webdriver"

require "simplecov"

SimpleCov.add_filter do |source_file|
  source_file.filename.include?('/features/step_definitions/')
end

SimpleCov.start

ActionController::Base.allow_rescue = false

# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome

# See https://cucumber.io/docs/cucumber/state/?lang=ruby#browser-automation-and-transactions
DatabaseCleaner.strategy = :truncation
Before { DatabaseCleaner.start }
After { DatabaseCleaner.clean }
