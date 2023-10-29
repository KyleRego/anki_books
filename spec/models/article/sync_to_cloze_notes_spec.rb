# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#sync_to_cloze_notes" do
  let(:sync_article_to_cloze_notes) { article.sync_to_cloze_notes(users:) }

  let(:users) { create_list(:user, 1) }
  let(:book) { create(:book, users:) }
  let(:article) { create(:article, book:, content:) }

  context "when article has no content" do
    let(:content) { "" }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when article has no clozes" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when content has one cloze for a concept that does not exist and article has no cloze notes" do
    let(:content) { "TCP is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }

    it "creates the concept that did not exist already" do
      expect { sync_article_to_cloze_notes }.to change(Concept, :count).by(1)
    end

    it "creates a cloze note for the concept" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
      expect(article.cloze_notes.first.sentence).to eq "TCP is a {{c1::protocol}}."
    end
  end

  context "when content has one cloze for a concept that already exists and article has no cloze notes" do
    let(:content) { "TCP is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before { create(:concept, user: users.first, name: "protocol") }

    it "creates a cloze note for the concept but does not create a new concept" do
      expect do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
      end.not_to change(Concept, :count)
      expect(article.cloze_notes.first.sentence).to eq "TCP is a {{c1::protocol}}."
    end
  end

  context "when content has one cloze but only two cloze notes (one is stale)" do
    let(:content) { "TCP is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      concept_one = create(:concept, user: users.first, name: "protocol")
      concept_two = create(:concept, user: users.first, name: "UDP")
      create(:cloze_note, sentence: "TCP is a {{c1::protocol}}.", article:, concepts: [concept_one])
      create(:cloze_note, sentence: "{{c1::UDP}} is a protocol.", article:, concepts: [concept_two])
    end

    it "deletes the stale cloze note" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(-1)
      expect(article.cloze_notes.first.sentence).to eq "TCP is a {{c1::protocol}}."
    end
  end

  context "when content has 2 clozes and one is for a concept that does not exist yet" do
    let(:content) { "{{c2::TCP}} is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }

    let!(:cloze_note) do
      concept = create(:concept, user: users.first, name: "protocol")
      create(:cloze_note, sentence: "TCP is a {{c1::protocol}}.", article:, concepts: [concept])
    end

    it "creates the concept updates the cloze note to have both concepts" do
      expect { sync_article_to_cloze_notes }.to change(Concept, :count).by(1)
      expect(cloze_note.reload.sentence).to eq "{{c2::TCP}} is a {{c1::protocol}}."
      expect(cloze_note.concepts.count).to eq 2
    end
  end

  context "when content has 2 clozes, both concepts exist, but matching cloze note has only one concept" do
    let(:content) { "{{c2::TCP}} is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }

    let!(:cloze_note) do
      concept = create(:concept, user: users.first, name: "protocol")
      create(:cloze_note, sentence: "TCP is a {{c1::protocol}}.", article:, concepts: [concept])
    end

    before { create(:concept, user: users.first, name: "TCP") }

    it "updates the cloze note to have both concepts" do
      sync_article_to_cloze_notes
      expect(cloze_note.reload.sentence).to eq "{{c2::TCP}} is a {{c1::protocol}}."
      expect(cloze_note.concepts.count).to eq 2
    end
  end

  context "when content has one cloze but the matching cloze note has two concepts" do
    let(:content) { "TCP is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }

    let!(:cloze_note) do
      concept_one = create(:concept, user: users.first, name: "protocol")
      concept_two = create(:concept, user: users.first, name: "TCP")
      create(:cloze_note, sentence: "{{c2::TCP}} is a {{c1::protocol}}.", article:, concepts: [concept_one, concept_two])
    end

    it "updates the cloze note to only has the current concept it needs" do
      sync_article_to_cloze_notes
      expect(cloze_note.reload.sentence).to eq "TCP is a {{c1::protocol}}."
      expect(cloze_note.concepts.count).to eq 1
      expect(cloze_note.concepts.first.name).to eq "protocol"
    end
  end

  context "when content has one cloze matching an existing concept but there is a difference in case" do
    let(:content) { "TCP is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests." }
    let!(:concept) { create(:concept, user: users.first, name: "Protocol") }

    it "creates the cloze note and case-insensitively matches it to the existing concept" do
      sync_article_to_cloze_notes
      expect(article.cloze_notes.first.concepts.first).to eq concept
    end
  end

  # TODO: Tests that ensure this behaves correctly for:
  context "when article belongs to a book with multiple users" do
    # rubocop:disable RSpec/PendingWithoutReason
    pending
    # rubocop:enable RSpec/PendingWithoutReason
  end
end
