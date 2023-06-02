# frozen_string_literal: true

require "pry"

require "cucumber/rails"
require "capybara/cucumber"
require "selenium-webdriver"
require "webdrivers"
require "simplecov"

SimpleCov.add_filter do |source_file|
  source_file.filename.include?("/features/step_definitions/")
end

SimpleCov.start do
  enable_coverage :branch
end

World(FactoryBot::Syntax::Methods)

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :truncation
Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless=new")
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium_chrome
