# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#anki_tag_name" do
  subject(:anki_tag_name) do
    book.anki_tag_name
  end

  let(:user) { create(:user) }
  let(:parent_book) { nil }
  let(:book) { create(:book, title: "A", users: [user], parent_book:) }

  it "returns the book title when the book title has no whitespace and book has no parent" do
    expect(anki_tag_name).to eq "A"
  end

  context "when book has a parent book" do
    let(:parent_book) { create(:book, title: "B", users: [user]) }

    it "returns the parent book and book titles as an Anki tag with nesting" do
      expect(anki_tag_name).to eq "B::A"
    end

    context "when book title and parent book title have multiple spaces" do
      let(:book) { create(:book, title: "R   A C", users: [user], parent_book:) }
      let(:parent_book) { create(:book, title: "B D  F", users: [user]) }

      it "replaces the spaces with underscores in a nested Anki tag" do
        expect(anki_tag_name).to eq "B_D__F::R___A_C"
      end
    end
  end

  context "when book title has a space" do
    let(:book) { create(:book, title: "A C", users: [user], parent_book:) }

    it "replaces the space with an underscore" do
      expect(anki_tag_name).to eq "A_C"
    end
  end
end
