# frozen_string_literal: true

RSpec.describe "Articles" do
  describe "GET /articles/:id/manage" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      context "when the article belongs to one of the user's books" do
        let(:book) { create(:book, users: [user]) }
        let(:article) { create(:article, book:) }

        it "returns a success response" do
          get manage_article_path(article)
          expect(response).to be_successful
        end
      end

      context "when the article does not belong to one of the user's books"
    end

    it "redirects to the root page when the user is not logged in" do
      article = create(:article)
      get manage_article_path(article)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(ApplicationController::NOT_LOGGED_IN_FLASH_MESSAGE)
    end
  end
end
