# Anki Concepts, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /concepts", "#create" do
  subject(:post_concepts_create) { post concepts_path, params: { concept: { name: } } }

  let(:name) { "the name" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "creates a new concept" do
      expect { post_concepts_create }.to change(Concept, :count).by 1
      expect(user.concepts.reload.last.name).to eq name
    end

    context "when the name parameter is blank" do
      let(:name) { "" }

      it "does not create a new concept and shows a flash alert" do
        expect { post_concepts_create }.not_to change(Concept, :count)
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
