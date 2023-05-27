# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#custom_study_cards_path" do
  it "returns the custom study cards path for the article" do
    article = create(:article)
    expect(article.custom_study_cards_path).to eq("/articles/#{article.id}/#{article.title_slug}/study_cards")
  end
end
