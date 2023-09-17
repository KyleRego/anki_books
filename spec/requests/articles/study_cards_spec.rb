# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /articles/:id/study_cards", "#study_cards" do
  subject(:get_articles_study_cards) { get study_article_cards_path(article) }

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }
  let(:basic_note) { create(:basic_note, article:) }

  include_examples "user is not logged in and needs to be"

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

      context "when the user's article is the system article" do
        let(:article) { create(:article, book:, system: true) }

        it "redirects to the homepage study cards page for the article" do
          get_articles_study_cards
          expect(response).to redirect_to(homepage_study_cards_path)
        end
      end
    end
  end
end
