# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#valid?" do
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
