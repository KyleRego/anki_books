# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ConceptsController do
  let(:concept_id) { "7" }

  describe "routing" do
    it "routes to #create" do
      expect(post: "/concepts").to route_to("concepts#create")
    end

    it "routes to #new" do
      expect(get: "/concepts/new").to route_to("concepts#new")
    end

    it "routes to #update" do
      expect(patch: "/concepts/#{concept_id}").to route_to("concepts#update", id: concept_id)
    end

    it "routes to #edit" do
      expect(get: "/concepts/#{concept_id}/edit").to route_to("concepts#edit", id: concept_id)
    end

    it "routes to #index" do
      expect(get: "/concepts").to route_to("concepts#index")
    end

    it "routes to #show" do
      expect(get: "/concepts/#{concept_id}").to route_to("concepts#show", id: concept_id)
    end

    it "routes to #destroy" do
      expect(delete: "/concepts/#{concept_id}").to route_to("concepts#destroy", id: concept_id)
    end

    it "routes to #manage" do
      expect(get: "/concepts/#{concept_id}/manage").to route_to("concepts#manage", id: concept_id)
    end
  end
end
