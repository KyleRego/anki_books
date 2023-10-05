# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /books/:id/change_parent_book", "#change_parent_book" do
  subject(:patch_books_change_parent_book) do
    patch change_parent_book_path(book), params:
  end

  let(:user) { create(:user) }
  let(:params) { { parent_book_id: parent_book.id } }
  let(:parent_book) { create(:book, users: [user]) }
  let(:book) { create(:book, users: []) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:book) { create(:book, users: [user]) }

    it "returns a success response" do
      patch_books_change_parent_book
      expect(response).to redirect_to(manage_book_path(book))
      expect(book.reload.parent_book).to eq parent_book
    end

    context "when params has a nil parent_book_id" do
      let(:params) { { parent_book_id: nil } }

      it "sets the parent_book_id to nil" do
        patch_books_change_parent_book
        expect(response).to redirect_to(manage_book_path(book))
        expect(book.reload.parent_book).to be_nil
      end
    end

    context "when params parent_book_id is the book" do
      let(:params) { { parent_book_id: book.id } }

      it "does not change the parent book to be itself" do
        patch_books_change_parent_book
        expect(response).to redirect_to(manage_book_path(book))
        expect(flash[:alert]).not_to be_empty
        expect(book.reload.parent_book).to be_nil
      end
    end

    context "when parent book cannot be found because it was deleted" do
      before { parent_book.destroy }

      it "redirects to the homepage" do
        patch_books_change_parent_book
        expect(response).to redirect_to(root_path)
      end
    end

    context "when parent book cannot be found because it is not the user's book" do
      let(:parent_book) { create(:book, users: []) }

      it "redirects to the homepage" do
        patch_books_change_parent_book
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
