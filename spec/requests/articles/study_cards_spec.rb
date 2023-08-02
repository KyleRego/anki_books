# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "GET /articles/:id/study_cards", "#study_cards" do
  subject(:get_articles_study_cards) { get study_article_cards_path(article) }

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }
  let(:basic_note) { create(:basic_note, article:) }

  it "redirects to the homepage with the not found message" do
    get_articles_study_cards
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq(ApplicationController::NOT_FOUND_FLASH_MESSAGE)
  end

  context "when the article is a system article" do
    let(:article) { create(:article, book:, system: true) }

    it "shows the study cards page even when the user is not logged in and needs to be" do
      get_articles_study_cards
      expect(response).to be_successful
    end
  end

  context "when the user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article does not belong to one of the user's books" do
      get_articles_study_cards
      expect(response).to redirect_to(root_path)
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      it "returns a 200 response" do
        get_articles_study_cards
        expect(response).to be_successful
      end
    end
  end
end
