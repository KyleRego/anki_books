# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Articles" do
  describe "GET /books/:id/articles/new" do
    context "when user is logged in" do
      let(:user) { create(:user) }
      let(:book) { create(:book, users: [user]) }
      let(:book_unrelated_to_user) { create(:book) }

      include_context "when the user is logged in"

      it "returns a success response if the article would belong to one of their books" do
        get new_book_article_path(book)
        expect(response).to be_successful
      end

      # TODO: This is probably the correct behavior we want for 404 responses
      it "throws a RecordNotFound exception if the user does not have a book with the given id" do
        expect { get new_book_article_path(book_unrelated_to_user) }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    it "redirects to the root page when the user is not logged in" do
      book = create(:book)
      get new_book_article_path(book)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(ApplicationController::NOT_LOGGED_IN_FLASH_MESSAGE)
    end
  end
end
