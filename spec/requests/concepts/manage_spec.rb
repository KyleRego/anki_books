# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /concepts/:id/manage", "#manage" do
  subject(:get_concepts_manage) { get manage_concept_path(concept) }

  let(:concept) { create(:concept, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the concept does not belong to the user" do
      get_concepts_manage
      expect(response).to redirect_to(root_path)
    end

    context "when the concept belongs to the user" do
      let(:concept) { create(:concept, user:) }

      it "returns a success response" do
        get_concepts_manage
        expect(response).to be_successful
      end

      context "when concept cannot be found because it was deleted" do
        before { concept.destroy }

        it "redirects to the homepage" do
          get_concepts_manage
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
