# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "GET /articles/:id/edit", "#edit" do
  subject(:get_articles_edit) { get edit_article_path(article) }

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article does not exist" do
      get "/articles/asdf/edit"
      expect(response).to redirect_to root_path
    end

    it "redirects to the homepage if it does not belong to one of the users' books" do
      get_articles_edit
      expect(response).to redirect_to root_path
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      it "returns a 200 response" do
        get_articles_edit
        expect(response).to be_successful
      end
    end
  end
end
