# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#content_without_cloze_markers" do
  subject(:content_without_cloze_markers) do
    article.content_without_cloze_markers.to_plain_text
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:, content:) }

  context "when content is nil" do
    let(:content) { nil }

    it "does not throw an exception" do
      expect { content_without_cloze_markers }.not_to raise_error
    end
  end

  context "when content has no {{ci::abc}}" do
    let(:content) { "Normal sentences. Content without special markers." }

    it "returns content" do
      expect(content_without_cloze_markers).to eq content
    end
  end

  context "when content has a {{ci::abc}} in a sentence" do
    let(:content) { "The {{c1::frontal lobes}} are part of the brain." }

    it "returns content without the cloze markers" do
      expected = "The frontal lobes are part of the brain."
      expect(content_without_cloze_markers).to eq expected
    end
  end

  context "when content has two {{ci::abc}} in a sentence" do
    let(:content) { "The {{c1::frontal lobes}} are part of the {{c2::brain}}." }

    it "returns content without the cloze markers" do
      expected = "The frontal lobes are part of the brain."
      expect(content_without_cloze_markers).to eq expected
    end
  end

  context "when content has multiple sentences" do
    let(:content) { "One sentence. One with a {{c1::cloze}}. Another {{c1::one}} here." }

    it "returns all sentences with a cloze" do
      expected = "One sentence. One with a cloze. Another one here."
      expect(content_without_cloze_markers).to eq expected
    end
  end
end
