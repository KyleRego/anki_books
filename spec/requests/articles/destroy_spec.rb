# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "DELETE /articles/:id", "#destroy" do
  subject(:delete_articles_destroy) do
    delete article_path(article)
  end

  let(:book) { create(:book) }
  let!(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  it "does not delete the article when the user is not logged in and needs to be" do
    expect { delete_articles_destroy }.not_to change(Article, :count)
    expect(response).to redirect_to login_path
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    context "when the article does not belong to one of the user's books" do
      it "does not delete the article and redirects to the homepage" do
        expect { delete_articles_destroy }.not_to change(Article, :count)
        expect(response).to redirect_to root_path
      end
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      before { 3.times { create(:basic_note, article:) } }

      it "deletes the article and redirects to show the book" do
        expect { delete_articles_destroy }.to change(Article, :count).by(-1)
        expect(response).to redirect_to book_path(book)
      end

      context "when the article is a system article" do
        let(:article) { create(:article, book:, system: true) }

        it "returns a 422 response if the article is a system article" do
          delete_articles_destroy
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when the article is the sixth in a book with 10 articles" do
      let!(:book) do
        book = create(:book, users: [user])
        create_list(:article, 10, book:)
        book
      end

      let(:article) { book.articles.find_by(ordinal_position: 5) }

      before do
        5.times do
          book = create(:book)
          create_list(:article, 15, book:)
        end
      end

      it "deletes the article and shifts the higher ordinal position articles down" do
        expect { delete_articles_destroy }.to change(Article, :count).by(-1)
        expect(book.articles.reload.pluck(:ordinal_position)).to eq [0, 1, 2, 3, 4, 5, 6, 7, 8]
      end
    end
  end
end
