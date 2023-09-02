# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /concepts/:id/edit", "#edit" do
  subject(:get_concepts_edit) { get edit_concept_path(concept) }

  let(:concept) { create(:concept, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:concept) { create(:concept, user:) }

    it "returns a success response" do
      get_concepts_edit
      expect(response).to be_successful
    end
  end
end
