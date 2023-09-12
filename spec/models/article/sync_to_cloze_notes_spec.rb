# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#sync_to_cloze_notes" do
  let(:sync_article_to_cloze_notes) { article.sync_to_cloze_notes }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:, content:) }

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

    before { create(:concept, books: [book], user:, name: "Rainbow") }

    it "does not change the number of cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
    end
  end

  context "when user has one matching concept, and article has no cloze notes" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before { create(:concept, books: [book], user:, name: "UDP") }

    it "creates a cloze note for the concept" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
      expect(article.cloze_notes.first.sentence).to eq "UDP is a protocol."
    end
  end

  context "when user has one matching concept, and cloze note is same as sentence" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      concept = create(:concept, books: [book], user:, name: "UDP")
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
      concept = create(:concept, books: [book], user:, name: "UDP")
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
      create(:concept, books: [book], user:, name: "UDP")
      concept = create(:concept, books: [book], user:, name: "Ethernet")
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
      create(:concept, books: [book], user:, name: "UDP")
      create(:concept, books: [book], user:, name: "link layer")
    end

    it "creates one cloze note for each of the two concept sentence matches" do
      expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(2)
      expect(article.cloze_notes.reload.pluck(:sentence).sort).to eq ["Ethernet is in the link layer.", "UDP is a protocol."]
    end
  end

  context "when user has two concepts which match the same sentence and an old cloze note for that sentence" do
    let(:content) { "TCP is a protocol. UDP is a protocol. Ethernet is in the link layer. Tests." }

    before do
      concept_one = create(:concept, books: [book], user:, name: "Ethernet")
      concept_two = create(:concept, books: [book], user:, name: "link layer")
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
      concept_one = create(:concept, books: [book], user:, name: "TCP")
      concept_two = create(:concept, books: [book], user:, name: "UDP")
      concept_three = create(:concept, books: [book], user:, name: "Link layer")
      concept_four = create(:concept, books: [book], user:, name: "Internet")
      create(:cloze_note, sentence: "Ethernet is in the blimpy Link layer.",
                          concepts: [concept_three],
                          article:)
      create(:cloze_note, sentence: "TCP and UDP.", concepts: [concept_one, concept_two], article:)
      create(:cloze_note, sentence: "Internet and web.", concepts: [concept_four], article:)
      create(:cloze_note, sentence: "Transport layer.", article:)
    end

    it "syncs the article content sentence to the article cloze notes" do
      expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
      expect(article.cloze_notes.reload.pluck(:sentence).sort).to eq ["Internet.", "Link layer.", "TCP.", "UDP."]
    end
  end

  context "when article is the neuroplasticity fixture article" do
    let(:article) { create(:neuroplasticity_article, book:) }

    context "when one concept that matches one sentence" do
      before do
        create(:concept, books: [book], user:, name: "structural neuroplasticity")
      end

      it "creates a cloze note for that sentence" do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
        expected_result = "Two types of neuroplasticity are often discussed: structural neuroplasticity and functional neuroplasticity."
        expect(article.cloze_notes.first.sentence).to eq expected_result
      end
    end

    context "when one concept matches a sentence that ends with a quotation around the term" do
      before do
        create(:concept, books: [book], user:, name: "nervous system")
      end

      it "creates a cloze note that keeps the quotation mark" do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(2)
      end
    end

    context "when there are many concepts" do
      let!(:concept_one) { create(:concept, books: [book], user:, name: "nervous system") }
      let!(:concept_two) { create(:concept, books: [book], user:, name: "neuron") }
      let!(:concept_three) { create(:concept, books: [book], user:, name: "brain") }

      let(:expected_cloze_sentences_after_sync) do
        # rubocop:disable Layout/LineLength
        ["However, researchers often describe neuroplasticity as \"the ability to make adaptive changes related to the structure and function of the nervous system.\"",
         "New neurons are constantly produced and integrated into the central nervous system throughout the life span based on this type of neuroplasticity.",
         "The core of this phenomenon is based upon synapses and how connections between them change based on neuron functioning.",
         "Neuroplasticity, also known as neural plasticity, or brain plasticity, is the ability of neural networks in the brain to change through growth and reorganization.",
         "There are a number of other factors that are thought to play a role in the biological processes underlying the changing of neural networks in the brain.",
         "Structural plasticity is often understood as the brain's ability to change its neuronal connections.",
         "Functional plasticity refers to brain's ability to alter and adapt the functional properties of neurons."].sort
        # rubocop:enable Layout/LineLength
      end

      it "creates the cloze notes from the article sentences" do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(7)
        expect(article.cloze_notes.reload.pluck(:sentence).sort).to eq expected_cloze_sentences_after_sync
      end

      context "when there are outdated cloze notes that need to be updated" do
        before do
          create(:cloze_note, article:, concepts: [concept_one], sentence: "The nervous system controls the muscles.")
          create(:cloze_note, article:, concepts: [concept_two], sentence: "A neuron is a type of cell.")
          create(:cloze_note, article:, concepts: [concept_three], sentence: "The brain can adapt to how it's being used.")
        end

        it "syncs the cloze notes with the article sentences" do
          expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(4)
          expect(article.cloze_notes.reload.pluck(:sentence).sort).to eq expected_cloze_sentences_after_sync
        end
      end

      context "when there is an outdated cloze note for a concept is not present anymore" do
        before do
          concept = create(:concept, books: [book], user:, name: "Organic Chemistry")
          create(:cloze_note, article:, concepts: [concept], sentence: "Sophomore chemistry students might study Organic Chemistry.")
        end

        it "deletes the outdated cloze note and syncs the cloze notes with the article sentences" do
          expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(6)
          expect(article.cloze_notes.reload.pluck(:sentence).sort).to eq expected_cloze_sentences_after_sync
        end
      end
    end

    context "when there is a sentence that matches two concepts" do
      let!(:concept_one) { create(:concept, books: [book], user:, name: "cytokines") }
      let!(:concept_two) { create(:concept, books: [book], user:, name: "phosphorylation") }
      let(:article_sentence) do
        # rubocop:disable Layout/LineLength
        "Some of these factors include synapse regulation via phosphorylation, the role of inflammation and inflammatory cytokines, proteins such as Bcl-2 proteins and neutrophorins, and energy production via mitochondria."
        # rubocop:enable Layout/LineLength
      end

      it "creates the cloze note from the article sentence" do
        expect { sync_article_to_cloze_notes }.to change(ClozeNote, :count).by(1)
        cloze_note = article.cloze_notes.first
        expect(cloze_note.sentence).to eq article_sentence
        expect(cloze_note.concepts.sort_by(&:name)).to eq [concept_one, concept_two]
      end

      context "when there is an outdated cloze note with those two concepts" do
        before do
          create(:cloze_note, article:,
                              concepts: [concept_one, concept_two],
                              sentence: "cytokines and phosphorylation.")
        end

        it "updates the existing cloze note to match the newer article sentence" do
          expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
          cloze_note = article.cloze_notes.first
          expect(cloze_note.sentence).to eq article_sentence
          expect(cloze_note.concepts.sort_by(&:name)).to eq [concept_one, concept_two]
        end
      end

      context "when the sentence is the same, but there is a new concept that matches the existing cloze note" do
        before do
          create(:cloze_note, article:, concepts: [concept_one], sentence: article_sentence)
        end

        it "updates the existing cloze note to have the new concept" do
          expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
          cloze_note = article.cloze_notes.first
          expect(cloze_note.sentence).to eq article_sentence
          expect(cloze_note.concepts.sort_by(&:name)).to eq [concept_one, concept_two]
        end
      end

      context "when the sentence is the same, but a concept has been removed from the new version of the sentence" do
        before do
          third_concept = create(:concept, books: [book], user:, name: "blimpy")
          create(:cloze_note, article:,
                              concepts: [concept_one, concept_two, third_concept],
                              sentence: article_sentence.gsub("phosphorylation", "blimpy phosphorylation"))
        end

        it "updates the existing cloze note to only have the two current concepts" do
          expect { sync_article_to_cloze_notes }.not_to change(ClozeNote, :count)
          cloze_note = article.cloze_notes.first
          expect(cloze_note.sentence).to eq article_sentence
          expect(cloze_note.concepts.sort_by(&:name)).to eq [concept_one, concept_two]
        end
      end
    end
  end
end
