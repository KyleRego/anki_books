# frozen_string_literal: true

Given "there is a user with username {string}, email {string}, and password {string}" do |string, string2, string3|
  User.create!(username: string, email: string2, password: string3)
end
