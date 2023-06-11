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

    it "routes to #show" do
      expect(get: "/books/#{book_id}").to route_to("books#show", id: book_id)
    end

    it "routes to #index" do
      expect(get: "/books").to route_to("books#index")
    end

    it "routes to #manage" do
      expect(get: "/books/#{book_id}/manage").to route_to("books#manage", id: book_id)
    end
  end
end
