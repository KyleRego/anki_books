# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /books/:id/update_child_books", "#update_child_books" do
  subject(:patch_books_update_child_books) do
    patch update_child_books_path(book), params: { child_book_ids: }
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:child_book_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the book manage page" do
      patch_books_update_child_books
      expect(response).to redirect_to(books_path)
      expect(flash[:notice]).not_to be_nil
    end

    context "when child_book_ids param is present" do
      before { create_list(:book, 10, users: [user]) }

      let(:child_book_ids) do
        user.books.where.not(id: book.id).first(4).pluck(:id).sort
      end

      it "updates the child books of the book" do
        patch_books_update_child_books
        expect(book.books.reload.pluck(:id).sort).to eq child_book_ids
      end
    end
  end
end
