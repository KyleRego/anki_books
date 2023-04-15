# frozen_string_literal: true

# Saves a screenshot to tmp/capybara
Then "show me the page" do
  @i ||= 0
  @i += 1
  page.save_screenshot("screenshot#{@i}.png", full: true)
  puts "Page screenshot saved to screenshot.png"
end

Then "I want to debug with pry" do
  binding.pry
end