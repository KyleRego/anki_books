# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeTextHelperModule, ".extract_concept_names_from_text" do
  subject(:extract_concept_names_from_text) do
    described_class.extract_concept_names_from_text(text:)
  end

  let(:text) { "  " }

  it "returns an empty array when text is blank" do
    expect(extract_concept_names_from_text).to eq []
  end

  context "when text has a {{ci::concept_name}}" do
    let(:text) do
      "Here is a {{c1::concept}}"
    end

    it "returns an array with the concept_name" do
      expect(extract_concept_names_from_text).to eq ["concept"]
    end
  end

  context "when text has two {{ci::}} cloze concept markers" do
    let(:text) do
      "A {{c1::cell}} is the smallest unit of {{c2::life}}"
    end

    it "returns an array with the two concept names" do
      expect(extract_concept_names_from_text).to eq %w[cell life]
    end
  end

  context "when text has multiple sentences and many cloze concept markers" do
    let(:text) do
      first_sentence = "{{c1::Caffeine}} is an antagonist to {{c2::adenosine}}.\n"
      second_sentence = "{{c3::Sleep}} is important.\n"
      third_sentence = " Here's another {{c4::concept}}"
      first_sentence + second_sentence + third_sentence
    end

    it "returns an array with all of the concept names" do
      expected_result = %w[Caffeine adenosine Sleep concept]
      expect(extract_concept_names_from_text).to eq expected_result
    end
  end
end
