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

  describe "#class_for_notes_area" do
    it "returns the class list including justify-start when user is logged in" do
      allow(helper).to receive(:logged_in?).and_return(true)

      expect(helper.class_for_notes_area).to eq("h-full flex flex-col justify-start")
    end

    it "returns the class list including justify-around when user is not logged in" do
      allow(helper).to receive(:logged_in?).and_return(false)

      expect(helper.class_for_notes_area).to eq("h-full flex flex-col justify-around")
    end
  end
end
