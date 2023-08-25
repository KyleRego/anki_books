# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /books/:id/change_article_ordinal_position", "#change_article_ordinal_position" do
  subject(:post_books_change_article_ordinal_position) do
    post change_book_article_ordinal_position_path(book),
         params: { article_id: article_to_move.id, new_ordinal_position: }
  end

  let!(:book) do
    book = create(:book)
    create_list(:article, 3, book:)
    book
  end
  # rubocop:disable RSpec/LetSetup
  let!(:article_starting_at_zero) { book.articles.find_by(ordinal_position: 0) }
  let!(:article_starting_at_one) { book.articles.find_by(ordinal_position: 1) }
  let!(:article_starting_at_two) { book.articles.find_by(ordinal_position: 2) }
  # rubocop:enable RSpec/LetSetup

  let(:article_to_move) { article_starting_at_two }
  let(:new_ordinal_position) { 0 }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    context "when the book does not belong to the user" do
      it "redirects to the homepage" do
        post_books_change_article_ordinal_position
        expect(response).to redirect_to root_path
      end
    end

    context "when the book belongs to the user" do
      let!(:book) do
        book = create(:book, users: [user])
        create_list(:article, 3, book:)
        book
      end

      it "changes the ordinal_position of the article and shifts the others" do
        post_books_change_article_ordinal_position
        expect(article_to_move.reload.ordinal_position).to eq new_ordinal_position
      end

      context "when the desired new_ordinal_position is negative" do
        let(:new_ordinal_position) { -1 }

        it "returns a 422 response" do
          post_books_change_article_ordinal_position
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the desired new_ordinal_position is the number of articles the book has" do
        let(:new_ordinal_position) { book.articles_count }

        it "returns a 422 response" do
          post_books_change_article_ordinal_position
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the desired new_ordinal_position is the ordinal position that the article has already" do
        let(:new_ordinal_position) { article_starting_at_one.ordinal_position }

        it "returns a 200 response" do
          post_books_change_article_ordinal_position
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
