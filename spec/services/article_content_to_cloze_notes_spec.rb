# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.xdescribe ArticleContentToClozeNotes do
  subject(:article_content_to_cloze_notes) do
    described_class.perform(user:, article:)
  end

  context "when the user has one concept" do
    let(:user) { create(:user) }
    let(:article) { create(:article, content:, book: create(:book, users: [user])) }

    before do
      create(:concept, name: "Chicken", user:)
    end

    context "when the article does not have a sentence matching the concept" do
      let(:content) { "Chickens are little bird animals." }

      it "does not create any cloze notes" do
        expect { article_content_to_cloze_notes }.not_to change(ClozeNote, :count)
      end
    end

    context "when the article has one sentence with the concept being the first word" do
      let(:content) { "Chicken refers to a small bird animal." }

      it "creates a cloze note belonging to the article and the concept" do
        expect { article_content_to_cloze_notes }.to change(ClozeNote, :count).by(1)
        cloze_note = ClozeNote.last
        expect(cloze_note.sentence).to eq article.content.to_plain_text
        expect(cloze_note.article.id).to eq article.id
        expect(cloze_note.concept.id).to eq concept.id
      end
    end

    context "when the article has three sentences, each with the concept" do
      let(:content) do
        "Chicken refers to a small bird animal. I see a Chicken. The Chicken is an animal."
      end

      it "creates three cloze notes belonging to the article and the concept" do
        expect { article_content_to_cloze_notes }.to change(ClozeNote, :count).by(3)
      end
    end

    context "when the article has 5 sentences and only 2 have the concept" do
      let(:content) do
        "Macaroni. I see a Chicken. Cats are silly. The Chicken is an animal."
      end

      it "creates 2 cloze notes belonging to the article and the concept" do
        expect { article_content_to_cloze_notes }.to change(ClozeNote, :count).by(2)
      end
    end

    context "when the article has sentences ending with punctuation other than a period" do
      let(:content) do
        "Macaroni! I see a Chicken! Cats are silly? The Chicken is an animal."
      end

      it "correctly determines the sentences" do
        expect { article_content_to_cloze_notes }.to change(ClozeNote, :count).by(2)
      end
    end
  end
end
