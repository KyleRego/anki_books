# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Books" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }

  let(:book_unrelated_to_user) { create(:book) }

  describe "GET /books/:id/edit" do
    context "when user is logged in" do
      include_context "when the user is logged in"

      it "returns a success response" do
        get(edit_book_path(book))
        expect(response).to be_successful
      end

      it "redirects to the homepage if the book is not found" do
        get "/books/asdf/edit"
        expect(response).to redirect_to(root_path)
      end

      it "redirects to the homepage if the book does not belong to the user" do
        get edit_book_path(book_unrelated_to_user)
        expect(response).to redirect_to(root_path)
      end
    end

    it "redirects to homepage if user is not logged in" do
      get(new_book_path)
      expect(response).to redirect_to root_path
    end
  end
end
