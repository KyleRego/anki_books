# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /concepts/:id", "#show" do
  subject(:get_concepts_show) { get concept_path(concept) }

  let(:concept) { create(:concept, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the concept does not belong to the user" do
      get_concepts_show
      expect(response).to redirect_to(root_path)
    end

    context "when the concept belongs to the user" do
      let(:concept) { create(:concept, user:) }

      it "returns a success response" do
        get_concepts_show
        expect(response).to be_successful
      end
    end

    it "redirects to the homepage if the concept is not found" do
      get "/concepts/asdf"
      expect(response).to redirect_to(root_path)
    end
  end
end
