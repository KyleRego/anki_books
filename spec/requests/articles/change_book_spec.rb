# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /articles/:id/change_book", "#change_book" do
  subject(:patch_articles_change_book) do
    patch change_article_book_path(article), params: { book_id: second_book.id }
  end

  let(:first_book) { create(:book) }
  let(:article) { create(:article, book: first_book) }
  let(:second_book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in and first book belongs to them" do
    let(:first_book) do
      book = create(:book, users: [user])
      create(:article, book:)
      book
    end
    let(:article) { first_book.articles.first }

    include_context "when the user is logged in"

    it "returns a 422 response if the second book does not belong to the user" do
      patch_articles_change_book
      expect(response).to have_http_status :unprocessable_entity
      expect(article.reload.book).to eq first_book
    end

    context "when the second book belongs to the user" do
      context "when the second book is the first book" do
        let(:second_book) { first_book }

        it "returns 200 response" do
          patch_articles_change_book
          expect(response).to have_http_status(:ok)
        end
      end

      context "when the second book is a different book" do
        let(:second_book) { create(:book, users: [user]) }

        it "changes the article's book if the book is found and belongs to the user" do
          patch_articles_change_book
          expect(response).to redirect_to(book_articles_path(first_book))
          expect(article.reload.book).to eq second_book
        end

        context "when first book has 5 articles" do
          let(:first_book) do
            book = create(:book, users: [user])
            create_list(:article, 5, book:)
            book
          end
          let(:article) { first_book.articles.find_by(ordinal_position: 0) }

          it "shifts down the ordinal positions of the articles from the first book" do
            patch_articles_change_book
            expect(response).to redirect_to(book_articles_path(first_book))
            expect(article.reload.book).to eq second_book
            expect(first_book.articles.pluck(:ordinal_position)).to eq [0, 1, 2, 3]
          end
        end
      end
    end

    it "returns a 404 response if the second book does not exist" do
      patch change_article_book_path(article), params: { book_id: "asdf" }
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
