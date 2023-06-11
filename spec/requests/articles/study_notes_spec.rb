# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "GET /articles/:id/study_cards" do
    it "returns a successful response" do
      get study_article_cards_path(article)
      expect(response).to be_successful
    end
  end
end
