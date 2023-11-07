# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#anki_deck_name" do
  subject(:anki_deck_name) do
    book.anki_deck_name
  end

  let(:user) { create(:user) }
  let(:parent_book) { nil }
  let(:book) { create(:book, title: "A", users: [user], parent_book:) }

  it "returns the book's title when book has no parent book" do
    expect(anki_deck_name).to eq "A"
  end

  context "when book has a parent book" do
    let(:parent_book) { create(:book, title: "B", users: [user]) }

    it "returns the parent book title, ::, and the book title concatenated together" do
      expect(anki_deck_name).to eq "B::A"
    end

    context "when parent book also has a parent" do
      let(:parent_book) do
        create(:book, title: "B", users: [user], parent_book: create(:book, title: "C", users: [user]))
      end

      it "returns C::B::A" do
        expect(anki_deck_name).to eq "C::B::A"
      end
    end
  end
end
