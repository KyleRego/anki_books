# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, "#custom_manage_path" do
  it "returns the custom manage path for the book" do
    book = create(:book)
    expect(book.custom_manage_path).to eq("/books/#{book.id}/#{book.title_slug}/manage")
  end
end
