# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Articles" do
  describe "POST /articles" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      include_context "when the user is logged in"

      context "when the target book belongs to the user" do
        let!(:book) { create(:book, users: [user]) }

        it "creates a new article" do
          params = { article: { title: "title", content: "", book_id: book.id } }
          expect { post articles_path, params: }.to change(Article, :count).by 1
        end

        it "creates a new article belonging to the book" do
          params = { article: { title: "title", content: "", book_id: book.id } }
          post(articles_path, params:)
          expect(Article.order(:created_at).last.book).to eq book
        end

        it "does not create a new article if the title was blank" do
          params = { article: { title: "", content: "", book_id: book.id } }
          expect { post(articles_path, params:) }.not_to change(Article, :count)
          expect(flash[:alert]).to eq("An article must have a title.")
        end
      end

      context "when the target book does not belong to the user" do
        let(:book_unrelated_to_user) { create(:book) }

        it "redirects to the homepage and does not create a new article" do
          params = { article: { title: "title", content: "", book_id: book_unrelated_to_user.id } }
          expect { post articles_path, params: }.not_to change(Article, :count)
          expect(response).to redirect_to root_path
        end
      end
    end

    it "redirects to the homepage and does not create a new article when the user is not logged in" do
      expect { post articles_path }.not_to change(Article, :count)
      expect(response).to redirect_to root_path
    end
  end
end
