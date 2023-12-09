# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeTextHelperModule, ".split_text_to_cloze_sentences" do
  subject(:split_text_to_cloze_sentences) do
    described_class.split_text_to_cloze_sentences(text:)
  end

  let(:text) { "" }

  it "returns an empty array when text is an empty string" do
    expect(split_text_to_cloze_sentences).to eq []
  end

  context "when text has a sentence with {{c1::abc}}" do
    let(:text) do
      "The {{c1::frontal lobes}} are part of the brain."
    end

    it "returns an array with just that sentence" do
      expected_result = ["The {{c1::frontal lobes}} are part of the brain."]
      expect(split_text_to_cloze_sentences).to eq expected_result
    end
  end

  context "when text has a sentence with two {{c1::abc}}" do
    let(:text) do
      "The {{c1::frontal lobes}} are part of the {{c2::brain}}."
    end

    it "returns an array with just that sentence" do
      expected_result = ["The {{c1::frontal lobes}} are part of the {{c2::brain}}."]
      expect(split_text_to_cloze_sentences).to eq expected_result
    end
  end

  context "when text has two sentences with {{ci::abc}}" do
    let(:text) do
      first_sentence = "A protein with a {{c1::binding site}} binds to a {{c2::ligand}}.\n"
      second_sentence = "The substrate of a protein which is an {{c1::enzyme}} is a {{c2::substrate}}."
      first_sentence + second_sentence
    end

    it "returns an array with both sentences" do
      expected_result = [
        "A protein with a {{c1::binding site}} binds to a {{c2::ligand}}.",
        "The substrate of a protein which is an {{c1::enzyme}} is a {{c2::substrate}}."
      ]
      expect(split_text_to_cloze_sentences).to eq expected_result
    end
  end
end
