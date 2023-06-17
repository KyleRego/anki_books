# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_redirected_to_root"

RSpec.describe "GET /articles/:id", "#show" do
  subject(:get_articles_show) { get article_path(article) }

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user not logged in gets redirected"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if it does not belong to one of the users' books" do
      get_articles_show
      expect(response).to redirect_to root_path
    end

    it "redirects to the homepage if the article does not exist" do
      get "/articles/asdf"
      expect(response).to redirect_to root_path
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      it "returns a 200 response" do
        get_articles_show
        expect(response).to be_successful
      end

      context "when the article is a system article" do
        let(:article) { create(:article, book:, system: true) }

        it "redirects to the root path" do
          get_articles_show
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
