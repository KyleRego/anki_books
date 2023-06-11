# frozen_string_literal: true

# TODO: Refactor all specs to use more shared contexts and examples through subjects

RSpec.describe "Articles" do
  describe "PATCH /articles/:id for a non-system article" do
    context "when the user is logged in" do
      let(:user) { create(:user) }

      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      context "when the article belongs to one of the user's books" do
        let(:book) { create(:book, users: [user]) }
        let(:article) { create(:article, book:) }

        # TODO: Refactoring
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
            expect(response).to redirect_to(article_path(article))
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

        # TODO: When the article does not belong to the user

        it "redirects to the root path (homepage) when it is the system article" do
          book = create(:book, users: [user])
          system_article = create(:article, book:, system: true)
          params = { article: { title: "New Title" } }
          patch article_path(system_article, params:)
          expect(response).to redirect_to root_path
        end
      end
    end

    it "redirects to the homepage when the user is not logged in" do
      article = create(:article)
      patch article_path(article), params: { article: { title: "New Title" } }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(ApplicationController::NOT_LOGGED_IN_FLASH_MESSAGE)
    end
  end
end
