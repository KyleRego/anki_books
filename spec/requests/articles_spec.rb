# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles" do
  let!(:article) { Article.create(title: "Hello World") }

  after { article.destroy }

  describe "GET /articles/anything", :temporary_spec do
    # rubocop:disable RSpec/MultipleExpectations
    it "is a basic test of the temporary root page" do
      get "/articles/a"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(article.title)
      expect(response.body).to include(article.content.to_s)
      expect(response.body).to include("Edit")
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
