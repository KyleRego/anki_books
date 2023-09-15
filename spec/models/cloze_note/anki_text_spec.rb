# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#anki_text" do
  subject(:anki_text) { cloze_note.anki_text }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:neuroplasticity_article, book:) }

  context "when cloze note has one concept - brain" do
    let(:cloze_note) do
      concept = create(:concept, user:, name: "brain")
      sentence = "Structural plasticity is brain's ability to change."
      create(:cloze_note, article:, sentence:, concepts: [concept])
    end

    it "returns an Anki cloze deletion version of the sentence" do
      expect(anki_text).to eq "Structural plasticity is {{c1::brain}}'s ability to change."
    end
  end

  context "when cloze note has one concept - nervous system" do
    let(:cloze_note) do
      concept = create(:concept, user:, name: "nervous system")
      sentence = "A quotation related to neuroplasticity is \"related to the nervous system.\""
      create(:cloze_note, article:, sentence:, concepts: [concept])
    end

    it "returns an Anki cloze deletion version of the sentence" do
      expect(anki_text).to eq "A quotation related to neuroplasticity is \"related to the {{c1::nervous system}}.\""
    end
  end

  context "when cloze note has two concepts - brain and nervous system" do
    let(:cloze_note) do
      concept_one = create(:concept, user:, name: "brain")
      concept_two = create(:concept, user:, name: "nervous system")
      sentence = "The nervous system includes the brain."
      create(:cloze_note, article:, sentence:, concepts: [concept_one, concept_two])
    end

    it "returns an Anki cloze deletion version with the cloze deletions having ci in alphabetic order" do
      expect(anki_text).to eq "The {{c2::nervous system}} includes the {{c1::brain}}."
    end
  end

  context "when cloze note has a concept in it twice" do
    let(:cloze_note) do
      concept = create(:concept, user:, name: "brain")
      sentence = "A brain is an example of a brain."
      create(:cloze_note, article:, sentence:, concepts: [concept])
    end

    it "returns an Anki cloze deletion version with two c1 cloze deletions for the concept" do
      expect(anki_text).to eq "A {{c1::brain}} is an example of a {{c1::brain}}."
    end
  end
end
