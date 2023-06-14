# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_found_redirects_to_homepage"

RSpec.describe "PATCH /articles/:id/change_book", "#change_book" do
  subject(:patch_articles_change_book) do
    patch change_article_book_path(article), params: { book_id: second_book.id }
  end

  let(:first_book) { create(:book) }
  let(:article) { create(:article, book: first_book) }
  let(:second_book) { create(:book) }

  include_examples "user not logged in gets redirected"

  context "when user is logged in and first book belongs to them" do
    let(:first_book) { create(:book, users: [user]) }

    include_context "when the user is logged in"

    it "returns a 422 response if the second book does not belong to the user" do
      patch_articles_change_book
      expect(response).to have_http_status :unprocessable_entity
      expect(article.reload.book).to eq first_book
    end

    context "when the second book belongs to the user" do
      let(:second_book) { create(:book, users: [user]) }

      it "changes the article's book if the book is found and belongs to the user" do
        patch_articles_change_book
        expect(response).to redirect_to(manage_article_path(article))
        expect(article.reload.book).to eq second_book
      end
    end

    it "returns a 422 response if the second book does not exist" do
      patch change_article_book_path(article), params: { book_id: "asdf" }
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
