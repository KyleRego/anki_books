# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController do
  let(:book_id) { "6" }
  let(:book_title) { "title" }

  describe "routing" do
    it "routes to #create" do
      expect(post: "/books").to route_to("books#create")
    end

    it "routes to #new" do
      expect(get: "/books/new").to route_to("books#new")
    end

    it "routes to #edit" do
      expect(get: "/books/#{book_id}/#{book_title}/edit").to route_to("books#edit", id: book_id, title: book_title)
    end

    it "routes to #show" do
      expect(get: "/books/#{book_id}/#{book_title}").to route_to("books#show", id: book_id, title: book_title)
    end

    it "routes to #update" do
      expect(patch: "/books/#{book_id}/#{book_title}").to route_to("books#update", id: book_id, title: book_title)
    end

    it "routes to #manage_articles" do
      expect(get: "/books/#{book_id}/#{book_title}/manage_articles").to route_to("books#manage_articles",
                                                                                 id: book_id,
                                                                                 title: book_title)
    end
  end
end
