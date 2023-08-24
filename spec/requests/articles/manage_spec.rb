# frozen_string_literal: true

RSpec.describe "GET /articles/:id/manage", "#manage" do
  subject(:get_articles_manage) { get manage_article_path(article) }

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article does not exist" do
      get "/articles/asdf/manage"
      expect(response).to redirect_to root_path
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }
      let(:article) { create(:article, book:) }

      it "returns a success response" do
        get_articles_manage
        expect(response).to be_successful
      end

      context "when the user has other books and the article's book has other articles" do
        before do
          create_list(:book, 4, users: [user])
          create_list(:article, 5, book:)
        end

        it "returns a success response" do
          get_articles_manage
          expect(response).to be_successful
        end
      end
    end
  end
end
