# frozen_string_literal: true

require "rails_helper"

RSpec.describe BookGroupsController do
  let(:book_group_id) { "2" }

  describe "routing" do
    it "routes to #create" do
      expect(post: "/book_groups").to route_to("book_groups#create")
    end

    it "routes to #new" do
      expect(get: "/book_groups/new").to route_to("book_groups#new")
    end

    it "routes to #update" do
      expect(patch: "/book_groups/#{book_group_id}").to route_to("book_groups#update", id: book_group_id)
    end

    it "routes to #edit" do
      expect(get: "/book_groups/#{book_group_id}/edit").to route_to("book_groups#edit", id: book_group_id)
    end

    it "routes to #show" do
      expect(get: "/book_groups/#{book_group_id}").to route_to("book_groups#show", id: book_group_id)
    end

    it "routes to #index" do
      expect(get: "/book_groups").to route_to("book_groups#index")
    end
  end
end
