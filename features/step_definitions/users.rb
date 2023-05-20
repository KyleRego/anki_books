# frozen_string_literal: true

Given "I am logged in" do
  visit login_path
  fill_in "Email", with: @test_user.email
  fill_in "Password", with: @test_user_password
  click_button "Log in"
  sleep 0.5
end

Given "there is a user with username {string}, email {string}, and password {string}" do |string, string2, string3|
  User.create!(username: string, email: string2, password: string3)
end
