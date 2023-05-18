# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { "Book title" }
    users { [] }
  end
end
