# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book do
  describe "validations" do
    it "is valid with a title" do
      book = build(:book, title: "Example Title")
      expect(book).to be_valid
    end

    it "is invalid with an empty string title" do
      book = build(:book, title: "")
      expect(book).to be_invalid
    end

    it "is invalid without a title" do
      book = build(:book, title: nil)
      expect(book).to be_invalid
    end
  end

  describe "title_slug" do
    it "sluggifies the article title" do
      book = build(:book, title: "Example Title . . for book")
      expect(book.title_slug).to eq "example-title-for-book"
    end
  end
end
