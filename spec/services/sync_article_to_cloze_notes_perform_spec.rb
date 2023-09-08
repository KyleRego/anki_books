# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe SyncArticleToClozeNotes, "#perform" do
  let(:sync_article_to_cloze_notes) { described_class.new(article:, user:).perform }

  let(:article) { create(:article, book: create(:book), content:) }
  let(:user) { create(:user) }

  context "when article has no content" do
    let(:content) { "" }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when article has content but user has no concepts" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests. UDP." }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when article has content and user has one concept which does not match" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests. UDP." }

    before { create(:concept, user:, name: "Rainbow") }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when article has content, user has one matching concept, and article has no cloze notes" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests. UDP." }

    before { create(:concept, user:, name: "UDP") }

    it "creates a cloze note for the concept" do
      pending "creating cloze notes"
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
      expect(user.cloze_notes.first.sentence).to eq "UDP is a protocol."
    end
  end

  context "when article has content, user has one matching concept, and cloze note is same as sentence" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests. UDP." }

    before do
      concept = create(:concept, user:, name: "UDP")
      create(:cloze_note, sentence: "UDP is a protocol.", concepts: [concept], article:)
    end

    it "does not update the cloze note" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
      expect(article.cloze_notes.first.sentence).to eq "UDP is a protocol."
    end
  end
end
