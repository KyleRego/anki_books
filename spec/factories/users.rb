# frozen_string_literal: true

TEST_USER_PASSWORD = "123a" * 4

FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { TEST_USER_PASSWORD }
  end
end
