# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, "#custom_path" do
  it "returns the custom path for the book" do
    book = create(:book)
    expect(book.custom_path).to eq("/books/#{book.id}/#{book.title_slug}")
  end
end
