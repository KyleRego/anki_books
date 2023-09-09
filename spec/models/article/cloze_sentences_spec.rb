# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#cloze_sentences" do
  subject(:cloze_sentences) { article.cloze_sentences(concept_name:) }

  let(:article) { create(:article, book: create(:book), content:) }
  let(:concept_name) { "TCP" }

  context "when article has no content" do
    let(:content) { "" }

    it "returns an empty array" do
      expect(cloze_sentences).to be_empty
    end
  end

  context "when article content is one sentence that has one match" do
    let(:content) { "UDP and TCP are protocols at the transport layer." }

    it "returns the matching sentence" do
      expect(cloze_sentences).to eq ["UDP and TCP are protocols at the transport layer."]
    end
  end

  context "when article content is one sentence that does not match" do
    let(:content) { "UDP and TCP are protocols at the transport layer." }
    let(:concept_name) { "Ruby on Rails" }

    it "returns an empty array" do
      expect(cloze_sentences).to be_empty
    end
  end

  context "when article content is two sentences where the first matches" do
    let(:content) { "TCP stands for transport control protocol. UDP is a different protocol." }

    it "returns the matching sentence" do
      expect(cloze_sentences).to eq ["TCP stands for transport control protocol."]
    end
  end

  context "when article content is two sentences where the second matches" do
    let(:content) { "UDP is a different protocol. TCP is used when all the data must arrive." }

    it "returns the matching sentence" do
      expect(cloze_sentences).to eq ["TCP is used when all the data must arrive."]
    end
  end

  context "when article content is two sentences and both match" do
    let(:content) { "The first transport protocol to know is TCP. TCP is used when all the data must arrive." }

    it "returns the matching sentences" do
      expect(cloze_sentences).to eq(
        ["The first transport protocol to know is TCP.", "TCP is used when all the data must arrive."]
      )
    end
  end

  context "when article content is 3 sentences with one match" do
    let(:content) { "A sentence. Here is TCP. A third sentence." }

    it "returns the matching sentence" do
      expect(cloze_sentences).to eq(["Here is TCP."])
    end
  end

  context "when article content has a sentence with more than one match in it" do
    let(:content) { "A sentence. Here is TCP in a sentence with TCP in it twice. A third sentence." }

    it "returns the matching sentence once" do
      expect(cloze_sentences).to eq(["Here is TCP in a sentence with TCP in it twice."])
    end
  end

  context "when article content has the last word of the last sentence as the match" do
    let(:content) { "First sentence, here. Second sentence ends up TCP." }

    it "returns the matching sentence" do
      expect(cloze_sentences).to eq(["Second sentence ends up TCP."])
    end
  end

  context "when article content has a sentence which is just the concept" do
    let(:content) { "TCP." }

    it "returns that as a match" do
      expect(cloze_sentences).to eq(["TCP."])
    end
  end

  context "when article content has a sentence matching a concept that ends in a double quotation" do
    let(:content) { "Neuroplasticity is related to the \"nervous system.\"" }
    let(:concept_name) { "nervous system" }

    it "returns that as a match including the quotation marks" do
      expect(cloze_sentences).to eq ["Neuroplasticity is related to the \"nervous system.\""]
    end
  end
end
