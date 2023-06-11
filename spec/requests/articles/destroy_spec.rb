# frozen_string_literal: true

RSpec.describe "Articles" do
  describe "DELETE /articles/:id" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      context "when the article belongs to one of the user's books" do
        let(:book) { create(:book, users: [user]) }
        let(:article) { create(:article, book:) }

        before { 3.times { create(:basic_note, article:) } }

        it "deletes the article and redirects to show the book" do
          expect { delete article_path(article) }.to change(Article, :count).by(-1)
          expect(response).to redirect_to book_path(book)
        end

        it "returns a 422 response if the article is a system article" do
          article.update(system: true)
          delete article_path(article)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the article does not belong to one of the user's books" do
        let(:book) { create(:book) }
        let!(:article) { create(:article, book:) }

        it "does not delete the article and redirects to the homepage" do
          expect { delete article_path(article) }.not_to change(Article, :count)
          expect(response).to redirect_to root_path
        end
      end
    end

    it "does not delete the article when the user is not logged in" do
      article = create(:article)
      expect { delete article_path(article) }.not_to change(Article, :count)
    end
  end
end
