# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  before do
    3.times { create(:basic_note, article:) }
  end

  describe "DELETE /articles/:id" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

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

    context "when not logged in" do
      it "does not delete the article" do
        expect { delete article_path(article) }.not_to change(Article, :count)
      end
    end
  end
end
