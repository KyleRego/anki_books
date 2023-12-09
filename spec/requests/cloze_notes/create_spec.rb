# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /articles/:article_id/cloze_notes", "#create" do
  subject(:post_cloze_notes_create) do
    post article_cloze_notes_path(article,
                                  format: :turbo_stream,
                                  cloze_note: { text: },
                                  ordinal_position:),
         headers: { "Turbo-Frame": turbo_id }
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:text) { " {{c1::hello world}}. " }
  let(:ordinal_position) { 0 }
  let(:turbo_id) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"

    context "when Turbo-Frame header is present" do
      let(:turbo_id) { Note.ordinal_position_zero_turbo_dom_id }

      context "when text does not have a cloze sentence" do
        let(:text) do
          "This is a sentence. And this is too. But there are no cloze concept markers."
        end

        it "returns a 200 Ok response with error explaining that the text must have a cloze sentence" do
          expect { post_cloze_notes_create }.not_to change(ClozeNote, :count)
          expect(response).to have_http_status(:ok)
          expect(response.body).to include "Text must have at least one cloze sentence"
        end
      end

      context "when text has one cloze sentence with one concept that does not exist yet" do
        let(:text) do
          "The organelle which creates ATP in eukaryotic cells is the {{c1::mitochondria}}."
        end

        it "creates a cloze note, concept, and associates them with each other" do
          expect { post_cloze_notes_create }.to change(ClozeNote, :count).by(1)
                                                                         .and change(Concept, :count).by(1)
          expect(article.cloze_notes.count).to eq 1
          expect(article.cloze_notes.first.concepts.first.name).to eq "mitochondria"
        end
      end

      context "when text has one cloze sentence with one concept that user has created before" do
        let(:text) do
          "The nucleus is surrounded by the {{c1::nuclear envelope}}."
        end

        before { create(:concept, user:, name: "nuclear envelope") }

        define_negated_matcher :not_change, :change
        it "creates a cloze note and associates it to the user's existing concept" do
          expect { post_cloze_notes_create }.to change(ClozeNote, :count).by(1)
                                                                         .and not_change(Concept, :count)
          expect(article.cloze_notes.count).to eq 1
          expect(article.cloze_notes.first.concepts.first.name).to eq "nuclear envelope"
        end
      end

      context "when text has two cloze sentences and 4 new concepts" do
        let(:text) do
          first_sentence = "There are {{c1::bacteria}}, {{c2::archaea}}, and {{c3::eukaryotes}}.\n"
          second_sentence = "Both bacteria and archaea are {{c1::prokaryotes}}.\n"
          first_sentence + second_sentence
        end

        it "creates two cloze notes and four concepts and associates concepts to the notes correctly" do
          expect { post_cloze_notes_create }.to change(ClozeNote, :count).by(2)
                                                                         .and change(Concept, :count).by(4)
          expect(user.cloze_notes.map { |cn| cn.concepts.count }.sort).to eq [1, 3]
        end
      end

      context "when text has one sentence with 5 concepts and only 2 concepts are new" do
        let(:text) do
          first_half = "Tulving's scheme proposes {{c1::semantic memory}}, {{c2::episodic memory}}, "
          second_half = "{{c3::procedural memory}}, {{c4::working memory}}, and {{c5::perceptual representation system}}."
          first_half + second_half
        end

        before do
          create(:concept, user:, name: "procedural memory")
          create(:concept, user:, name: "SEMANTIC MEMORY")
        end

        it "creates one cloze note and 3 concepts and associates concepts to the notes correctly" do
          expect { post_cloze_notes_create }.to change(ClozeNote, :count).by(1)
                                                                         .and change(Concept, :count).by(3)
          expected_concept_names = ["SEMANTIC MEMORY", "episodic memory",
                                    "perceptual representation system", "procedural memory", "working memory"]
          expect(article.cloze_notes.first.concepts.map(&:name).sort).to eq expected_concept_names
        end
      end

      context "when text param is blank" do
        let(:text) { "   " }

        it "does not create a cloze note" do
          expect { post_cloze_notes_create }.not_to change(ClozeNote, :count)
          # TODO: Call a method on this string with normal ' that escapes it for equality
          expect(response.body).to include "Text can&#39;t be blank"
        end
      end

      context "when creating cloze note in the middle of an article with notes" do
        before do
          create(:basic_note, article:, ordinal_position: 0)
          create(:cloze_note, article:, ordinal_position: 1)
          create(:basic_note, article:, ordinal_position: 2)
          create(:cloze_note, article:, ordinal_position: 3)
          create(:basic_note, article:, ordinal_position: 4)
          create(:cloze_note, article:, ordinal_position: 5)
        end

        let(:turbo_id) { article.notes.find_by(ordinal_position: 2).new_next_sibling_note_turbo_id }
        let(:ordinal_position) { 3 }

        it "creates the cloze note at that position and shifts other notes" do
          expect { post_cloze_notes_create }.to change(ClozeNote, :count).by(1)
          expect(article.reload.correct_children_ordinal_positions?).to be true
          expect(article.notes.order(:created_at).last.ordinal_position).to eq 3
        end
      end
    end
  end
end
