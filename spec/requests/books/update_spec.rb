# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_is_unauthorized"

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
          expect(flash[:alert]).to eq("A book must have a title.")
        end
      end
    end
  end
end
