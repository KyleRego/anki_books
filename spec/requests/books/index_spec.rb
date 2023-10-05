# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /books", "#index" do
  subject(:get_books_index) { get(books_path) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a success response" do
      get_books_index
      expect(response).to be_successful
    end

    context "when user has books including books with parent books" do
      before do
        create_list(:book, 20, users: [user])
        parent_book = user.books.first
        parent_book.books << user.books.last(3)
        second_parent_book = parent_book.books.first
        second_parent_book.books << user.books.last(6).first(3)
      end

      it "returns a success response" do
        get_books_index
        expect(response).to be_successful
      end
    end
  end
end
