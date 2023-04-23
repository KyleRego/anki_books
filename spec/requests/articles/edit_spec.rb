# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "GET /articles/:id/:title/edit" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
        get edit_article_path(article, title: article.title_slug)
      end

      it "returns a success response" do
        expect(response).to be_successful
      end
    end

    context "when user is not logged in" do
      before do
        get edit_article_path(article, title: article.title_slug)
      end

      it "redirects to the root page" do
        expect(response).to redirect_to(root_path)
      end

      it "shows a flash alert message" do
        expect(flash[:alert]).to eq("You must be logged in to access this page.")
      end
    end
  end
end
