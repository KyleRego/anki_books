# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe FixOrdinalPositionsJob, ".perform" do
  subject(:fix_ordinal_positions_job) { described_class.perform_now }

  context "when a book has one article with an incorrect ordinal positions" do
    let(:book) { create(:book) }

    before do
      create_list(:article, 2, book:)
      bad_ord_pos_article = book.articles.second
      bad_ord_pos_article.ordinal_position = 2
      bad_ord_pos_article.save(validate: false)
    end

    it "fixes the ordinal positions" do
      expect(book.correct_children_ordinal_positions?).to be false
      fix_ordinal_positions_job
      expect(book.correct_children_ordinal_positions?).to be true
    end
  end

  context "when book has multiple articles with incorrect ordinal positions" do
    let(:book) { create(:book) }

    before do
      create_list(:article, 10, book:)
      first_bad_ord_pos_article = book.articles.second
      second_bad_ord_pos_article = book.articles.fourth
      third_bad_ord_pos_article = book.articles[7]
      first_bad_ord_pos_article.ordinal_position = 11
      second_bad_ord_pos_article.ordinal_position = 20
      third_bad_ord_pos_article.ordinal_position = 15
      first_bad_ord_pos_article.save(validate: false)
      second_bad_ord_pos_article.save(validate: false)
      third_bad_ord_pos_article.save(validate: false)
    end

    it "fixes the ordinal positions" do
      expect(book.correct_children_ordinal_positions?).to be false
      fix_ordinal_positions_job
      expect(book.correct_children_ordinal_positions?).to be true
    end
  end

  context "when article has multiple basic notes with incorrect ordinal positions" do
    let(:article) { create(:article, book: create(:book)) }

    before do
      create_list(:basic_note, 10, article:)
      first_basic_note = article.basic_notes.first
      second_basic_note = article.basic_notes.second
      third_basic_note = article.basic_notes.third
      fourth_basic_note = article.basic_notes[6]
      first_basic_note.ordinal_position = 15
      second_basic_note.ordinal_position = 11
      third_basic_note.ordinal_position = 13
      fourth_basic_note.ordinal_position = 25
      first_basic_note.save(validate: false)
      second_basic_note.save(validate: false)
      third_basic_note.save(validate: false)
      fourth_basic_note.save(validate: false)
    end

    it "fixes the ordinal positions" do
      expect(article.correct_children_ordinal_positions?).to be false
      fix_ordinal_positions_job
      article.basic_notes.reload
      expect(article.reload.correct_children_ordinal_positions?).to be true
    end
  end
end
