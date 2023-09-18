# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /books/:id/transfer_articles", "#transfer_articles" do
  subject(:patch_books_transfer_articles) do
    params = { target_book_id: target_book.id, article_ids: }
    patch book_transfer_articles_path(book), params:
  end

  let(:book) { create(:book) }
  let(:target_book) { create(:book) }
  let(:article_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    # TODO: Look into this
    # rubocop:disable RSpec/RepeatedExampleGroupBody

    context "when only the source book belongs to the user (and not target book)" do
      let(:book) { create(:book, users: [user]) }

      it "redirects to the homepage" do
        patch_books_transfer_articles
        expect(response).to redirect_to(root_path)
      end
    end

    context "when only the target book belongs to the user (and not source book)" do
      let(:book) { create(:book, users: [user]) }

      it "redirects to the homepage" do
        patch_books_transfer_articles
        expect(response).to redirect_to(root_path)
      end
    end

    # rubocop:enable RSpec/RepeatedExampleGroupBody

    context "when the source book and target book both belong to the user" do
      let(:book) { create(:book, users: [user]) }
      let(:target_book) { create(:book, users: [user]) }

      before { create_list(:article, 10, book:) }

      context "when article_ids params has some of the ids of the source book articles" do
        let(:article_ids) { book.articles.first(5).map(&:id) }

        it "moves the articles to target book and redirects to the manage book page" do
          patch_books_transfer_articles
          expect(response).to redirect_to(manage_book_path(book))
          expect(book.correct_children_ordinal_positions?).to be true
          expect(target_book.correct_children_ordinal_positions?).to be true
          expect(target_book.articles.count).to eq 5
          expect(target_book.articles.pluck(:id).sort).to eq article_ids.sort
        end

        context "when the target book already has some articles" do
          before { create_list(:article, 5, book: target_book) }

          it "moves the articles to target book at the end" do
            patch_books_transfer_articles
            expect(response).to redirect_to(manage_book_path(book))
            expect(book.correct_children_ordinal_positions?).to be true
            expect(target_book.correct_children_ordinal_positions?).to be true
            expect(target_book.articles.count).to eq 10
            expect(target_book.articles.ordered.last(5).pluck(:id).sort).to eq article_ids.sort
          end
        end
      end

      context "when article_ids param has the ids of all articles in the source book" do
        let(:article_ids) { book.articles.pluck(:id) }

        it "moves the articles to target book redirects to the manage source book page" do
          patch_books_transfer_articles
          expect(response).to redirect_to(manage_book_path(book))
          expect(book.correct_children_ordinal_positions?).to be true
          expect(target_book.correct_children_ordinal_positions?).to be true
          expect(target_book.articles.count).to eq 10
          expect(target_book.articles.pluck(:id).sort).to eq article_ids.sort
        end
      end

      context "when article_ids param has some but not all article ids from a different book" do
        let(:valid_article_ids) { book.articles.first(6).map(&:id) }
        let(:invalid_article_ids) do
          book = create(:book)
          create_list(:article, 3, book:).map(&:id)
        end
        let(:article_ids) { valid_article_ids + invalid_article_ids }

        it "redirects to the manage article page and moves only the articles of the book" do
          patch_books_transfer_articles
          expect(response).to redirect_to(manage_book_path(book))
          expect(book.correct_children_ordinal_positions?).to be true
          expect(target_book.correct_children_ordinal_positions?).to be true
          expect(target_book.articles.count).to eq 6
          expect(target_book.articles.pluck(:id).sort).to eq valid_article_ids.sort
        end
      end

      context "when article_ids param only article_ids but none from source book" do
        let(:article_ids) { create_list(:article, 5, book: create(:book, users: [user])) }

        it "returns a 422 response" do
          patch_books_transfer_articles
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
