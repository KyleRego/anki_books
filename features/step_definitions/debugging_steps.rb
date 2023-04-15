# frozen_string_literal: true

# Saves a screenshot to tmp/capybara
Then "screenshot" do
  @i ||= 0
  @i += 1
  page.save_screenshot("screenshot#{@i}.png", full: true)
  puts "Page screenshot saved to screenshot.png"
end

# rubocop:disable Lint/Debugger
Then "pry" do
  binding.pry
end
# rubocop:enable Lint/Debugger
