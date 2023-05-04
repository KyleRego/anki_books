# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArticlesController do
  let(:user_id) { "6" }
  let(:article_id) { "1e8e5d81-09b4-4757-bbea-f024997d6b35" }
  let(:article_title) { "slug-title" }

  describe "routing" do
    it "routes to #homepage" do
      expect(get: "/").to route_to("articles#homepage")
    end

    it "routes to #create" do
      path = "/users/#{user_id}/articles"
      expect(post: path).to route_to("articles#create", user_id:)
    end

    it "routes to #edit" do
      path = "/articles/#{article_id}/#{article_title}/edit"
      expect(get: path).to route_to("articles#edit", id: article_id, title: article_title)
    end

    it "routes to #update" do
      path = "/articles/#{article_id}/#{article_title}"
      expect(patch: path).to route_to("articles#update", id: article_id, title: article_title)
    end

    it "routes to #show" do
      path = "/articles/#{article_id}/#{article_title}"
      expect(get: path).to route_to("articles#show", id: article_id, title: article_title)
    end

    it "routes to #change_note_ordinal_position" do
      path = "/articles/#{article_id}/change_note_ordinal_position"
      expect(post: path).to route_to("articles#change_note_ordinal_position", id: article_id)
    end
  end
end
