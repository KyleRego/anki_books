# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles", type: :request do
  before { @article = Article.create(title: "Hello World") }
  after { @article.destroy }
  describe "GET /articles/anything", :temporary_spec do
    it "should be a good endpoint to test Trix" do
      get "/articles/a"
      expect(response).to have_http_status(200)
      expect(response.body).to include(@article.title)
      expect(response.body).to include(@article.content.to_s)
      expect(response.body).to include("Edit")
    end
  end
end
