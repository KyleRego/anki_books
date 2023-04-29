# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "POST /users/:user_id/articles/new" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "creates a new article" do
        expect { post new_article_path(user_id: user.id) }.to change(Article, :count).by 1
      end
    end

    context "when not logged in" do
      it "does not create a new article" do
        expect { post new_article_path(user_id: user.id) }.not_to change(Article, :count)
      end
    end
  end
end
