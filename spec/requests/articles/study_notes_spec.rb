# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "GET /articles/:id/:title/study_cards" do
    it "returns a successful response" do
      get article_study_cards_path(article, title: article.title)
      expect(response).to be_successful
    end
  end
end