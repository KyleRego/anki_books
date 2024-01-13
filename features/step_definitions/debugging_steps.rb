# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# Saves a screenshot to tmp/capybara
Then "screenshot" do
  @i ||= 0
  @i += 1
  page.save_screenshot("screenshot#{@i}.png", full: true)
  puts "Page screenshot saved to screenshot#{@i}.png"
end

Then "show JavaScript console" do
  puts page.driver.browser.logs.get(:browser)
end
