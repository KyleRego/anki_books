# frozen_string_literal: true

FactoryBot.define do
  factory :book_group do
    title { "Book group title" }
    users { [] }
  end
end
