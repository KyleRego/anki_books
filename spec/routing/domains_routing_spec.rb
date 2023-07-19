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
  end
end
