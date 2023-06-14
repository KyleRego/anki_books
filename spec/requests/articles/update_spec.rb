# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_found_redirects_to_homepage"

RSpec.describe "PATCH /articles/:id for a non-system article", "#update" do
  subject(:patch_articles_update) do
    params = { article: { title:, content: } }
    patch article_path(article), params:
  end

  let(:title) { "new title 1 2 3" }
  let(:content) { "some content" }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user not logged in gets redirected"

  context "when the user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article does not belong to one of the user's books" do
      patch_articles_update
      expect(response).to redirect_to root_path
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      context "when the article belongs to one of the user's books" do
        let(:book) { create(:book, users: [user]) }

        it "updates the article and redirects to the article" do
          patch_articles_update
          expect(article.reload.title).to eq(title)
          expect(flash[:notice]).to eq("Article updated successfully.")
          expect(response).to redirect_to(article_path(article))
        end

        context "when it is the system article" do
          let(:article) { create(:article, book:, system: true) }

          it "updates the article and redirects to the root path" do
            patch_articles_update
            expect(article.reload.title).to eq(title)
            expect(flash[:notice]).to eq("Article updated successfully.")
            expect(response).to redirect_to root_path
          end
        end

        context "when the parameters are invalid" do
          let(:title) { "" }

          it "does not update the article" do
            patch_articles_update
            expect(article.reload.title).not_to eq("")
            expect(flash[:alert]).to eq("The article must have a title.")
          end
        end
      end
    end
  end
end
