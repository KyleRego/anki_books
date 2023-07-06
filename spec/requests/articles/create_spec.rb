# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "POST /articles", "#create" do
  subject(:post_articles_create) do
    params = { article: { title:, content: "", book_id: book.id } }
    post articles_path, params:
  end

  let(:title) { "title" }
  let(:content) { "" }
  let(:book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage and does not create a new article if the book does not belong to the user" do
      expect { post_articles_create }.not_to change(Article, :count)
      expect(response).to redirect_to root_path
    end

    context "when the book belongs to the user" do
      let!(:book) { create(:book, users: [user]) }
      let(:created_article) { Article.order(:created_at).last }

      it "creates a new article" do
        expect { post_articles_create }.to change(Article, :count).by 1
      end

      it "creates a new article belonging to the book with the first ordinal position" do
        post_articles_create
        expect(created_article.book).to eq book
        expect(created_article.ordinal_position).to eq 0
      end

      context "when the title parameter is blank" do
        let(:title) { "" }

        it "does not create a new article" do
          expect { post_articles_create }.not_to change(Article, :count)
          expect(flash[:alert]).to eq("An article must have a title.")
        end
      end

      context "when the book already had an article" do
        before { create(:article, book:) }

        it "creates a new article belonging to the book with the second ordinal position" do
          post_articles_create
          expect(created_article.book).to eq book
          expect(created_article.ordinal_position).to eq 1
        end
      end
    end
  end
end
