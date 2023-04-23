# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "GET /articles/:uuid/:title" do
    it "shows the article" do
      get article_path(article, title: article.title)
      expect(response).to be_successful
    end
  end
end
