# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }

  # rubocop:disable RSpec/NestedGroups
  describe "PATCH /articles/:id for a non-system article" do
    let(:book) { create(:book) }
    let(:article) { create(:article, book:) }

    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      context "with valid params" do
        let(:valid_params) { { article: { title: "New Title" } } }

        before do
          patch article_path(article), params: valid_params
        end

        it "updates the article" do
          expect(article.reload.title).to eq("New Title")
        end

        it "shows a notice flash message" do
          expect(flash[:notice]).to eq("Article updated successfully.")
        end

        it "redirects to the article" do
          expect(response).to redirect_to(article_path(article.reload))
        end
      end

      context "with invalid params" do
        let(:invalid_params) { { article: { title: "" } } }

        before do
          patch article_path(article), params: invalid_params
        end

        it "does not update the article" do
          expect(article.reload.title).not_to eq("")
        end

        it "shows an alert flash message" do
          expect(flash[:alert]).to eq("The article must have a title.")
        end
      end
    end

    context "when user is not logged in" do
      before do
        patch article_path(article), params: { article: { title: "New Title" } }
      end

      it "redirects to the root page" do
        expect(response).to redirect_to(root_path)
      end

      it "shows an alert flash message" do
        expect(flash[:alert]).to eq("You must be logged in to access this page.")
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups

  describe "PATCH /articles/:id for a system article" do
    let(:system_article) { create(:article, system: true) }
    let(:valid_params) { { article: { title: "New Title" } } }

    before do
      post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      patch article_path(system_article), params: valid_params
    end

    it "redirects to the root path (homepage)" do
      expect(response).to redirect_to root_path
    end
  end
end
