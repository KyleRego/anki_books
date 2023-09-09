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

  context "when user has no concepts" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when user has one concept which does not match" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before { create(:concept, user:, name: "Rainbow") }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when user has one matching concept, and article has no cloze notes" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before { create(:concept, user:, name: "UDP") }

    it "creates a cloze note for the concept" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
      expect(article.cloze_notes.first.sentence).to eq "UDP is a protocol."
    end
  end

  context "when user has one matching concept, and cloze note is same as sentence" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      concept = create(:concept, user:, name: "UDP")
      create(:cloze_note, sentence: "UDP is a protocol.", concepts: [concept], article:)
    end

    it "does not update the cloze note" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
      expect(article.cloze_notes.first.sentence).to eq "UDP is a protocol."
    end
  end

  context "when user has one matching concept, a same cloze note, and a stale cloze note" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      concept = create(:concept, user:, name: "UDP")
      create(:cloze_note, sentence: "UDP is a protocol.", concepts: [concept], article:)
      create(:cloze_note, sentence: "UDP.", concepts: [concept], article:)
    end

    it "does not change the note which is the same and deletes the other" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(-1)
      expect(article.cloze_notes.first.sentence).to eq "UDP is a protocol."
    end
  end

  context "when user has two matching concepts, a same cloze note, and a stale cloze note" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      create(:concept, user:, name: "UDP")
      concept = create(:concept, user:, name: "Ethernet")
      create(:cloze_note, sentence: "Kitty cats.", concepts: [concept], article:)
    end

    it "syncs the two existing notes to be two new notes" do
      sync_article_to_cloze_notes
      expect(article.cloze_notes.reload.pluck(:sentence).sort).to eq ["Ethernet is in the link layer.", "UDP is a protocol."]
    end
  end

  context "when user has two concepts which match two sentences and no cloze notes" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      create(:concept, user:, name: "UDP")
      create(:concept, user:, name: "link layer")
    end

    it "creates one cloze note for each of the two concept sentence matches" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(2)
      expect(article.cloze_notes.pluck(:sentence).sort).to eq ["Ethernet is in the link layer.", "UDP is a protocol."]
    end
  end

  context "when user has two concepts which match the same sentence and an old cloze note for that sentence" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      concept_one = create(:concept, user:, name: "Ethernet")
      concept_two = create(:concept, user:, name: "link layer")
      create(:cloze_note, sentence: "Ethernet is in the blimpy link layer.",
                          concepts: [concept_one, concept_two],
                          article:)
    end

    it "updates the cloze note for the two concepts" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
      expect(article.cloze_notes.pick(:sentence)).to eq "Ethernet is in the link layer."
    end
  end

  context "when article has many sentences and user has many concepts" do
    let(:content) { "TCP. UDP. Ethernet. Link layer. Transport layer. Internet. IP. Packet. Segment. Datagram." }

    before do
      concept_one = create(:concept, user:, name: "TCP")
      concept_two = create(:concept, user:, name: "UDP")
      concept_three = create(:concept, user:, name: "Link layer")
      concept_four = create(:concept, user:, name: "Internet")
      create(:cloze_note, sentence: "Ethernet is in the blimpy Link layer.",
                          concepts: [concept_three],
                          article:)
      create(:cloze_note, sentence: "TCP and UDP.", concepts: [concept_one, concept_two], article:)
      create(:cloze_note, sentence: "Internet and web.", concepts: [concept_four], article:)
      create(:cloze_note, sentence: "Transport layer.", article:)
    end

    it "syncs the article content sentence to the article cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
      expect(article.cloze_notes.pluck(:sentence).sort).to eq ["Internet.", "Link layer.", "TCP.", "UDP."]
    end
  end

  context "when article content is article_content.txt" do
    let(:content) do
      art_cont_path = Rails.root.join("spec/services/sync_article_to_cloze_notes/article_content.txt")
      File.read(art_cont_path)
    end

    context "when one concept that matches one sentence" do
      before do
        create(:concept, user:, name: "structural neuroplasticity")
      end

      it "creates a cloze note for that sentence" do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
        result = "Two types of neuroplasticity are often discussed: structural neuroplasticity and functional neuroplasticity."
        expect(article.cloze_notes.first.sentence).to eq result
      end
    end

    context "when one concept matches a sentence that ends with a quotation around the term" do
      before do
        create(:concept, user:, name: "nervous system")
      end

      it "creates a cloze note that keeps the quotation mark" do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(2)
      end
    end
  end
end
