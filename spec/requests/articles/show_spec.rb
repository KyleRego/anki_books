# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }

  describe "GET /articles/:id/:title when the article exists" do
    let(:article) { create(:article) }
    let(:system_article) { create(:article, system: true) }

    it "shows the article" do
      get article.custom_path
      expect(response).to be_successful
    end

    it "redirects to homepage if it is a system article" do
      get system_article.custom_path
      expect(response).to redirect_to root_path
    end
  end

  describe "GET /articles/:id/:title when the article does not exist" do
    it "redirects to homepage" do
      get "/articles/asdf/asdf-title"
      expect(flash[:alert]).to eq "No article was found for that URL path or identifier."
      expect(response).to redirect_to root_path
    end
  end
end
