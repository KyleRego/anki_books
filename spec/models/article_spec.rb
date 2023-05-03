# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article do
  describe "validations" do
    it "is valid with a title" do
      article = build(:article, title: "Example Title")
      expect(article).to be_valid
    end

    it "is invalid with an empty string title" do
      article = build(:article, title: "")
      expect(article).to be_invalid
    end

    it "is invalid without a title" do
      article = build(:article, title: nil)
      expect(article).to be_invalid
    end
  end

  describe "#title_slug" do
    it "sluggifies the article title" do
      article = build(:article, title: "Example Title")
      expect(article.title_slug).to eq "example-title"
    end
  end

  describe "#notes_count" do
    it "returns the number of notes the article has" do
      article = create(:article)
      create_list(:basic_note, 3, article:)
      expect(article.notes_count).to eq 3
    end
  end
end
