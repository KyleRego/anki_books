# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:first_book) { create(:book, users: [user]) }
  let(:article) { create(:article, book: first_book) }

  let(:second_book) { create(:book, users: [user]) }

  let(:book_unrelated_to_user) { create(:book) }

  describe "PATCH /articles/:id/change_book" do
    context "when user is logged in" do
      include_context "when the user is logged in"

      it "changes the article's book if the book is found and belongs to the user" do
        patch change_article_book_path(article), params: { book_id: second_book.id }
        expect(response).to redirect_to(manage_article_path(article))
        expect(article.reload.book).to eq second_book
      end

      it "returns a 422 response if the book does not exist" do
        patch change_article_book_path(article), params: { book_id: "asdf" }
        expect(response).to have_http_status :unprocessable_entity
      end

      it "returns a 422 response if the book does not belong to the user" do
        patch change_article_book_path(article), params: { book_id: book_unrelated_to_user.id }
        expect(response).to have_http_status :unprocessable_entity
        expect(article.reload.book).to eq first_book
      end
    end

    it "redirects to the root path when user is not logged in" do
      patch change_article_book_path(article), params: { book_id: second_book.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
