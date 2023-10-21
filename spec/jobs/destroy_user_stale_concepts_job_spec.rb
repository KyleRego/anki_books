# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe DestroyUserStaleConceptsJob do
  subject(:destroy_user_stale_concepts_job) do
    described_class.perform_now(user:)
  end

  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article) }

  before do
    create_list(:concept, 10, user:)
  end

  context "when user only has concepts with no dependent cloze notes" do
    it "deletes all of their concepts" do
      expect { destroy_user_stale_concepts_job }.to change(Concept, :count).by(-10)
    end
  end

  context "when user has some concepts with and some without dependent cloze notes" do
    let(:with_cloze_one) { user.concepts.first }
    let(:with_cloze_two) { user.concepts.fourth }
    let(:with_cloze_three) { user.concepts.last }

    before do
      create(:cloze_note, concepts: [with_cloze_one], article:)
      create(:cloze_note, concepts: [with_cloze_two], article:)
      create(:cloze_note, concepts: [with_cloze_three], article:)
    end

    it "destroys the concepts that have no dependent cloze notes" do
      expect { destroy_user_stale_concepts_job }.to change(Concept, :count).by(-7)
      expect(user.concepts.pluck(:id).sort).to eq [with_cloze_one, with_cloze_two, with_cloze_three].map(&:id).sort
    end
  end
end
