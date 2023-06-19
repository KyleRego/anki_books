# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { "Hello World" }
    book { create(:book) }
    ordinal_position { book.articles_count }
  end
end
