# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, "#title_slug" do
  it "sluggifies the article title" do
    book = build(:book, title: "Example Title . . for book")
    expect(book.title_slug).to eq "example-title-for-book"
  end
end
