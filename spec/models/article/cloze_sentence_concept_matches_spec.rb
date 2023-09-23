# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#cloze_sentence_concept_matches" do
  subject(:cloze_sentence_concept_matches) do
    article.cloze_sentence_concept_matches(concepts:)
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, content:, book:) }
  let(:concepts) { [] }

  context "when one concept name includes a different concept name" do
    let(:content) { "The central executive is not as central as originally conceived." }
    let(:concepts) do
      [create(:concept, user:, name: "central executive"), create(:concept, user:, name: "executive")]
    end

    it "creates a match between only the longer concept name and cloze sentence" do
      expect(cloze_sentence_concept_matches.size).to eq 1
      match = cloze_sentence_concept_matches.first
      expect(match.sentence).to eq content
      expect(match.concepts.count).to eq 1
      expect(match.concepts.first.name).to eq "central executive"
    end
  end

  context "when one concept name appears twice, once inside another concept name" do
    let(:content) { "The central executive might be more like a group of executive functions." }
    let(:concepts) do
      [create(:concept, user:, name: "central executive"),
       create(:concept, user:, name: "executive")]
    end

    it "creates one match with the sentence to both concepts" do
      expect(cloze_sentence_concept_matches.size).to eq 1
      match = cloze_sentence_concept_matches.first
      expect(match.sentence).to eq content
      expect(match.concepts.count).to eq 2
      expect(match.concepts.map(&:name).sort).to eq ["central executive", "executive"]
    end
  end

  context "when one concept name includes a different concept name that also appears inside a different word" do
    let(:content) { "A third technique is exception aggregation: handling many exceptions with a single piece of code." }
    let(:concept_one) { create(:concept, user:, name: "exception aggregation") }
    let(:concept_two) { create(:concept, user:, name: "exception") }
    let(:concepts) { [concept_one, concept_two] }

    it "creates a match with the concept" do
      expect(cloze_sentence_concept_matches.size).to eq 1
      match = cloze_sentence_concept_matches.first
      expect(match.sentence).to eq content
      expect(match.concepts.count).to eq 1
      expect(match.concepts.map(&:name).sort).to eq ["exception aggregation"]
    end
  end
end
