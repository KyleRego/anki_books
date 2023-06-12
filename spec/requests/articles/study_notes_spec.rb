# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Articles" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "GET /articles/:id/study_cards" do
    context "when the article is a system article" do
      let(:book) { create(:book) }
      let(:system_article) { create(:article, book:, system: true) }

      it "shows the study cards page even when the user is not logged in" do
        get study_article_cards_path(system_article)
        expect(response).to be_successful
      end
    end

    context "when the article is a normal article" do
      context "when the user is logged in and the article belongs to one of their books" do
        let(:user) { create(:user) }
        let(:book) { create(:book, users: [user]) }
        let(:article) { create(:article, book:) }

        include_context "when the user is logged in"

        it "shows the study cards page even when the user is not logged in" do
          get study_article_cards_path(article)
          expect(response).to be_successful
        end
      end

      context "when the user is logged in and the article does not belong to them" do
        let(:user) { create(:user) }
        let(:book) { create(:book) }
        let(:article) { create(:article, book:) }

        include_context "when the user is logged in"

        it "redirects to the homepage" do
          get study_article_cards_path(article)
          expect(response).to redirect_to(root_path)
        end
      end

      context "when the user is not logged in" do
        let(:book) { create(:book) }
        let(:article) { create(:article, book:) }

        it "redirects to the homepage" do
          get study_article_cards_path(article)
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
