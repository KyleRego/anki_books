# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "ArticlesHelper" do
  describe "#back_to_article_path" do
    let(:article) { create(:article) }
    let(:system_article) { create(:article, system: true) }

    it "returns article path for non-system article" do
      expect(helper.back_to_article_path(article)).to eq article_path(article)
    end

    it "returns root path for system article" do
      expect(helper.back_to_article_path(system_article)).to eq "/"
    end
  end
end
