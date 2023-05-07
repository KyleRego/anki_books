# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:system_article) { create(:article, system: true) }

  describe "GET /articles/:id/:title" do
    it "shows the article" do
      get article_path(article, title: article.title_slug)
      expect(response).to be_successful
    end

    it "redirects to homepage if it is a system article" do
      get(article_path(system_article, title: system_article.title_slug))
      expect(response).to redirect_to root_path
    end
  end
end
