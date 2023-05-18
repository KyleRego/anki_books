# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  describe "POST /users/:user_id/articles/new" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "creates a new article" do
        params = { article: { title: "title", content: "", book_id: book.id } }
        expect { post new_article_path(user), params: }.to change(Article, :count).by 1
      end

      it "creates a new article belonging to the book" do
        params = { article: { title: "title", content: "", book_id: book.id } }
        post(new_article_path(user), params:)
        expect(article.book).to eq book
      end
    end

    context "when not logged in" do
      it "does not create a new article" do
        expect { post new_article_path(user) }.not_to change(Article, :count)
      end
    end
  end
end
