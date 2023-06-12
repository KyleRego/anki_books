# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Books" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }

  let(:book_unrelated_to_user) { create(:book) }

  describe "PATCH /books/:id" do
    context "when user is logged in" do
      include_context "when the user is logged in"

      it "updates the book" do
        patch book_path(book), params: { book: { title: "the title" } }
        expect(book.reload.title).to eq "the title"
      end

      it "does not update the book if the title was blank" do
        patch book_path(book), params: { book: { title: "" } }
        expect(flash[:alert]).to eq("A book must have a title.")
      end

      it "does not update the book if it does not belong to the user" do
        patch book_path(book_unrelated_to_user), params: { book: { title: "the title" } }
        expect(book_unrelated_to_user.reload.title).not_to eq "the title"
      end
    end

    context "when not logged in" do
      it "does not update the book" do
        patch book_path(book), params: { book: { title: "the title" } }
        expect(book.reload.title).not_to eq "the title"
      end
    end
  end
end
