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

      context "when the concept has some cloze notes" do
        before do
          book = create(:book, users: [user])
          article = create(:article, book:)
          concept = create(:concept, user:, name: "nervous system")
          create(:cloze_note, cloze_text: "Research into the {{c1::nervous system}} oftentimes is related to neuroplasticity.",
                              concepts: [concept], article:)
          create(:cloze_note, cloze_text: "New neurons continue to grow throughout the life of the {{c1::nervous system}}.",
                              concepts: [concept], article:)
        end

        it "returns a success response" do
          get_concepts_show
          expect(response).to be_successful
        end
      end

      context "when concept is not found (it was deleted)" do
        before { concept.destroy }

        it "redirects to the homepage" do
          get_concepts_show
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
