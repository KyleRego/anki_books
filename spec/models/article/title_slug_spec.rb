# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#title_slug" do
  it "sluggifies the article title" do
    article = build(:article, title: "Example Title")
    expect(article.title_slug).to eq "example-title"
  end
end
