# frozen_string_literal: true

require "rails_helper"

RSpec.describe DomainsController do
  let(:domain_id) { "2" }

  describe "routing" do
    it "routes to #create" do
      expect(post: "/domains").to route_to("domains#create")
    end

    it "routes to #new" do
      expect(get: "/domains/new").to route_to("domains#new")
    end

    it "routes to #update" do
      expect(patch: "/domains/#{domain_id}").to route_to("domains#update", id: domain_id)
    end

    it "routes to #edit" do
      expect(get: "/domains/#{domain_id}/edit").to route_to("domains#edit", id: domain_id)
    end

    it "routes to #show" do
      expect(get: "/domains/#{domain_id}").to route_to("domains#show", id: domain_id)
    end

    it "routes to #index" do
      expect(get: "/domains").to route_to("domains#index")
    end

    it "routes to #root_domains" do
      expect(get: "/root_domains").to route_to("domains#root_domains")
    end

    it "routes to #destroy" do
      expect(delete: "/domains/#{domain_id}").to route_to("domains#destroy", id: domain_id)
    end

    it "routes to #manage" do
      expect(get: "/domains/#{domain_id}/manage").to route_to("domains#manage", id: domain_id)
    end

    it "routes to #study_cards" do
      expect(get: "/domains/#{domain_id}/study_cards").to route_to("domains#study_cards", id: domain_id)
    end

    it "routes to #change_books" do
      expect(patch: "/domains/#{domain_id}/change_books").to route_to("domains#change_books", id: domain_id)
    end

    it "routes to #change_child_domains" do
      expect(patch: "/domains/#{domain_id}/change_child_domains").to route_to("domains#change_child_domains", id: domain_id)
    end
  end
end
