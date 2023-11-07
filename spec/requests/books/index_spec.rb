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
        create_list(:book, 5, users: [user])
        parent_book = user.books.first
        children_of_parent = create_list(:book, 3, users: [user])
        parent_book.books << children_of_parent
        second_parent_book = children_of_parent.first
        children_of_second_parent = create_list(:book, 3, users: [user])
        second_parent_book.books << children_of_second_parent
      end

      it "returns a success response" do
        get_books_index
        expect(response).to be_successful
      end
    end
  end
end
