# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArticlesHelper" do
  describe "#back_to_article_path" do
    let(:article) { create(:article) }
    let(:system_article) { create(:article, system: true) }

    it "returns article path for non-system article" do
      expect(helper.back_to_article_path(article)).to eq helper.article_path(article, title: article.title_slug)
    end

    it "returns root path for system article" do
      expect(helper.back_to_article_path(system_article)).to eq "/"
    end
  end
end
