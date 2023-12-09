# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.xdescribe Article, "#cloze_sentence_concepts_structs" do
  subject(:cloze_sentence_concepts_structs) do
    article.cloze_sentence_concepts_structs
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:, content:) }

  context "when article has no content" do
    let(:content) { "" }

    it "returns an empty array" do
      expect(cloze_sentence_concepts_structs).to eq []
    end
  end

  context "when content has a {{ci::abc}} in a sentence" do
    let(:content) { "The {{c1::frontal lobes}} are part of the brain." }

    it "returns an array of one struct for that sentence with one concept" do
      sentence = "The {{c1::frontal lobes}} are part of the brain."
      concept = "frontal lobes"
      struct = ClozeSentenceConcepts.new(sentence:, concepts: [concept])
      expect(cloze_sentence_concepts_structs).to eq [struct]
    end
  end

  context "when content has two {{ci::abc}} in a sentence" do
    let(:content) { "The {{c1::frontal lobes}} are part of the {{c2::brain}}." }

    it "returns an array of one struct for that sentence with 2 concepts" do
      sentence = "The {{c1::frontal lobes}} are part of the {{c2::brain}}."
      concepts = ["frontal lobes", "brain"]
      struct = ClozeSentenceConcepts.new(sentence:, concepts:)
      expect(cloze_sentence_concepts_structs).to eq [struct]
    end
  end

  context "when content has two sentences each with one cloze" do
    let(:content) { "One sentence. One with a {{c1::cloze}}. Another {{c1::one}} here." }

    it "returns an array of two structs each with one concept" do
      struct_one = ClozeSentenceConcepts.new(sentence: "One with a {{c1::cloze}}.", concepts: ["cloze"])
      struct_two = ClozeSentenceConcepts.new(sentence: "Another {{c1::one}} here.", concepts: ["one"])
      expect(cloze_sentence_concepts_structs).to eq [struct_one, struct_two]
    end
  end

  context "when content has three sentences, one with one and two with two clozes" do
    let(:content) { "One {{c1::super}} {{c2::sentence}}. One {{c2::with}} a {{c1::cloze}}. Another {{c1::one}} here." }

    it "returns an array of three structs each with their concepts" do
      struct_one = ClozeSentenceConcepts.new(sentence: "One {{c1::super}} {{c2::sentence}}.", concepts: %w[super sentence])
      struct_two = ClozeSentenceConcepts.new(sentence: "One {{c2::with}} a {{c1::cloze}}.", concepts: %w[with cloze])
      struct_three = ClozeSentenceConcepts.new(sentence: "Another {{c1::one}} here.", concepts: ["one"])
      expect(cloze_sentence_concepts_structs).to eq [struct_one, struct_two, struct_three]
    end
  end
end
