# frozen_string_literal: true

RSpec.describe "Articles" do
  describe "GET /books/:id/articles/new" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      let(:book) { create(:book, users: [user]) }
      let(:book_unrelated_to_user) { create(:book) }

      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

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
