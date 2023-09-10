# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#notes" do
  include_context "when the user has two books, three articles, 5 basic notes per article"

  it "returns the basic notes of the user's books' articles" do
    expect(user.basic_notes.count).to eq 15
  end

  context "when there are basic notes that do not belong to the user" do
    before do
      article = create(:article)
      create_list(:basic_note, 10, article:)
    end

    it "does not include the other basic notes" do
      expect(user.basic_notes.count).to eq 15
    end
  end

  context "when there are basic notes that do belong to a different user" do
    before do
      other_user = create(:user)
      book = create(:book, users: [other_user])
      article = create(:article, book:)
      create_list(:basic_note, 10, article:)
    end

    it "does not include the other user's basic notes" do
      expect(user.basic_notes.count).to eq 15
    end
  end

  context "when the user also has a third book with 4 articles with 2 basic notes each" do
    before do
      book = create(:book, users: [user])
      articles = create_list(:article, 4, book:)
      articles.each { |article| create_list(:basic_note, 2, article:) }
    end

    it "returns the basic notes of the user's books' articles" do
      expect(user.basic_notes.count).to eq 23
    end

    context "when there are basic notes that do belong to a different user" do
      before do
        other_user = create(:user)
        book = create(:book, users: [other_user])
        article = create(:article, book:)
        create_list(:basic_note, 10, article:)
      end

      it "does not include the other user's basic notes" do
        expect(user.basic_notes.count).to eq 23
      end
    end
  end
end
