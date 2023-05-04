# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#notes_count" do
  it "returns the number of notes the article has" do
    article = create(:article)
    create_list(:basic_note, 3, article:)
    expect(article.notes_count).to eq 3
  end
end
