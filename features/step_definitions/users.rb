# frozen_string_literal: true

Given "I am logged in" do
  password = "1234abcd1234"
  user = create(:user, password:)
  visit login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: password
  click_button "Log in"
  sleep 0.5
end

Given "there is a user with username {string}, email {string}, and password {string}" do |string, string2, string3|
  User.create!(username: string, email: string2, password: string3)
end
