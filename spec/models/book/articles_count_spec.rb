# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, "#articles_count" do
  it "returns 0 when the book has no articles" do
    book = create(:book)
    expect(book.articles_count).to eq 0
  end

  it "returns 1 when the book has one article" do
    book = create(:book)
    create(:article, book:)
    expect(book.articles_count).to eq 1
  end
end
