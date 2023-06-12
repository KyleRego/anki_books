# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Articles" do
  describe "GET /articles/:id" do
    let(:user) { create(:user) }
    let(:book) { create(:book, users: [user]) }
    let(:article) { create(:article, book:) }

    let(:book_unrelated_to_user) { create(:book) }
    let(:article_unrelated_to_user) { create(:article, book: book_unrelated_to_user) }

    let(:system_article) { create(:article, book:, system: true) }

    context "when user is logged in" do
      include_context "when the user is logged in"

      it "shows the article if it belongs to one of the users' books" do
        get article_path(article)
        expect(response).to be_successful
      end

      it "redirects to the homepage if it does not belong to one of the users' books" do
        get article_path(article_unrelated_to_user)
        expect(response).to redirect_to root_path
      end

      it "redirects to the homepage if the article does not exist" do
        get "/articles/asdf"
        expect(response).to redirect_to root_path
      end

      it "redirects to homepage if it is a system article" do
        get article_path(system_article)
        expect(response).to redirect_to root_path
      end
    end

    it "redirects to the homepage when the user is not logged in" do
      get article_path(article)
      expect(flash[:alert]).to eq ApplicationController::NOT_LOGGED_IN_FLASH_MESSAGE
      expect(response).to redirect_to root_path
    end
  end
end
