# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /books/:id/edit", "#edit" do
  subject(:get_books_edit) { get(edit_book_path(book)) }

  let(:book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the book does not belong to the user" do
      get_books_edit
      expect(response).to redirect_to(root_path)
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "returns a success response" do
        get_books_edit
        expect(response).to be_successful
      end

      context "when book cannot be found because it was deleted" do
        before { book.destroy }

        it "redirects to the homepage" do
          get_books_edit
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
