# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController do
  let(:book_id) { "6" }

  describe "routing" do
    it "routes to #create" do
      expect(post: "/books").to route_to("books#create")
    end

    it "routes to #new" do
      expect(get: "/books/new").to route_to("books#new")
    end

    it "routes to #update" do
      expect(patch: "/books/#{book_id}").to route_to("books#update", id: book_id)
    end

    it "routes to #edit" do
      expect(get: "/books/#{book_id}/edit").to route_to("books#edit", id: book_id)
    end

    it "routes to #show" do
      expect(get: "/books/#{book_id}").to route_to("books#show", id: book_id)
    end

    it "routes to #index" do
      expect(get: "/books").to route_to("books#index")
    end

    it "routes to #change_article_ordinal_position" do
      path = "/books/#{book_id}/change_article_ordinal_position"
      expect(post: path).to route_to("books#change_article_ordinal_position", id: book_id)
    end

    it "routes to #manage" do
      path = "/books/#{book_id}/manage"
      expect(get: path).to route_to("books#manage", id: book_id)
    end

    it "routes to #study_cards" do
      path = "/books/#{book_id}/study_cards"
      expect(get: path).to route_to("books#study_cards", id: book_id)
    end
  end
end
