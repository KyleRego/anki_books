# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "DELETE /concepts/:id", "#destroy" do
  subject(:delete_concepts_destroy) do
    delete concept_path(concept)
  end

  let!(:concept) { create(:concept, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  it "does not delete the concept when the user is not logged in and needs to be" do
    expect { delete_concepts_destroy }.not_to change(Concept, :count)
    expect(response).to redirect_to login_path
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    context "when the concept does not belong to the user" do
      it "does not delete the concept and redirects to the homepage" do
        expect { delete_concepts_destroy }.not_to change(Concept, :count)
        expect(response).to redirect_to root_path
      end
    end

    context "when the concept does belong to the user" do
      let(:concept) { create(:concept, user:) }

      it "deletes the concept and redirects to the user's concepts" do
        expect { delete_concepts_destroy }.to change(Concept, :count).by(-1)
        expect(response).to redirect_to concepts_path
      end
    end
  end
end
