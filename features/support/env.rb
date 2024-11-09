# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "pry"

require "cucumber/rails"
require "capybara/cucumber"
require "selenium-webdriver"

require_relative "../../spec/simplecov_helper"

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
