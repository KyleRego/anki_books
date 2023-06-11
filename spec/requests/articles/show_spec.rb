# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }

  describe "GET /articles/:id when the article exists" do
    let(:article) { create(:article) }
    let(:system_article) { create(:article, system: true) }

    it "shows the article" do
      get article_path(article)
      expect(response).to be_successful
    end

    it "redirects to homepage if it is a system article" do
      get article_path(system_article)
      expect(response).to redirect_to root_path
    end
  end

  describe "GET /articles/:id when the article does not exist" do
    it "redirects to homepage" do
      get "/articles/asdf"
      expect(flash[:alert]).to eq "No article was found for that URL path or identifier."
      expect(response).to redirect_to root_path
    end
  end
end
