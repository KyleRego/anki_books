# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArticlesHelper" do
  describe "#article_path_or_root_path_if_system" do
    let(:article) { create(:article) }
    let(:system_article) { create(:article, system: true) }

    it "returns article path for non-system article" do
      expect(helper.article_path_or_root_path_if_system(article)).to eq helper.article_path(article,
                                                                                            title: article.title_slug)
    end

    it "returns root path for system article" do
      expect(helper.article_path_or_root_path_if_system(system_article)).to eq "/"
    end
  end
end
