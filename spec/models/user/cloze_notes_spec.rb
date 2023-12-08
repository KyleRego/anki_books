# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#cloze_notes" do
  subject(:cloze_notes) do
    user.cloze_notes
  end

  let(:user) { create(:user) }

  it "returns an empty relation when user has no cloze notes" do
    expect(cloze_notes).to be_empty
  end

  context "when user has one article with 10 cloze notes" do
    before do
      book = create(:book, users: [user])
      article = create(:article, book:)
      create_list(:cloze_note, 10, article:)
    end

    it "returns 10 cloze notes" do
      expect(cloze_notes.count).to eq 10
    end
  end

  context "when user has 30 cloze notes spread over different books and articles" do
    before do
      book1 = create(:book, users: [user])
      article1 = create(:article, book: book1)
      article2 = create(:article, book: book1)
      book2 = create(:book, users: [user])
      article3 = create(:article, book: book2)
      create_list(:cloze_note, 10, article: article1)
      create_list(:cloze_note, 10, article: article2)
      create_list(:cloze_note, 10, article: article3)
    end

    it "returns 30 cloze notes" do
      expect(cloze_notes.count).to eq 30
    end
  end
end
