# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#ordered_notes" do
  subject(:ordered_notes) do
    book.ordered_notes
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, title: "Testing book", users: [user]) }

  context "when book has 3 articles each with 3 basic notes" do
    before do
      create_list(:article, 3, book:)
      book.articles.each { |a| create_list(:basic_note, 3, article: a) }
    end

    it "returns the notes ordered by article order" do
      first_article_id = book.articles.find_by(ordinal_position: 0).id
      second_article_id = book.articles.find_by(ordinal_position: 1).id
      third_article_id = book.articles.find_by(ordinal_position: 2).id

      expect(ordered_notes.first.article_id).to eq first_article_id
      expect(ordered_notes.second.article_id).to eq first_article_id
      expect(ordered_notes.third.article_id).to eq first_article_id
      expect(ordered_notes.fourth.article_id).to eq second_article_id
      expect(ordered_notes.fifth.article_id).to eq second_article_id
      expect(ordered_notes[5].article_id).to eq second_article_id
      expect(ordered_notes[6].article_id).to eq third_article_id
      expect(ordered_notes[7].article_id).to eq third_article_id
      expect(ordered_notes[8].article_id).to eq third_article_id
    end

    it "returns the notes in order from inside each article" do
      expect(ordered_notes.first.ordinal_position).to eq 0
      expect(ordered_notes.second.ordinal_position).to eq 1
      expect(ordered_notes.third.ordinal_position).to eq 2
      expect(ordered_notes.fourth.ordinal_position).to eq 0
      expect(ordered_notes.fifth.ordinal_position).to eq 1
      expect(ordered_notes[5].ordinal_position).to eq 2
      expect(ordered_notes[6].ordinal_position).to eq 0
      expect(ordered_notes[7].ordinal_position).to eq 1
      expect(ordered_notes[8].ordinal_position).to eq 2
    end
  end
end
