# frozen_string_literal: true

require "rails_helper"

RSpec.describe BookGroup, "#valid?" do
  it "is valid with a title" do
    book_group = build(:book_group, title: "Example Title")
    expect(book_group).to be_valid
  end

  it "is invalid with an empty string title" do
    book_group = build(:book_group, title: "")
    expect(book_group).to be_invalid
  end

  it "is invalid without a title" do
    book_group = build(:book_group, title: nil)
    expect(book_group).to be_invalid
  end
end
