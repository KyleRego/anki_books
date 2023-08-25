# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /books/:id", "#update" do
  subject(:patch_books_update) { patch book_path(book), params: { book: { title: } } }

  let(:book) { create(:book) }
  let(:title) { "the title" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "does not update the book if it does not belong to the user" do
      patch_books_update
      expect(book.reload.title).not_to eq "the title"
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "updates the book" do
        patch_books_update
        expect(book.reload.title).to eq "the title"
      end

      context "when the title parameter is blank" do
        let(:title) { "" }

        it "does not update the book if the title was blank" do
          patch_books_update
          expect(flash[:alert]).not_to be_nil
        end
      end
    end
  end
end
