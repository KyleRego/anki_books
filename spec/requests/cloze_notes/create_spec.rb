# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /articles/:article_id/cloze_notes", "#create" do
  subject(:post_cloze_notes_create) do
    post article_cloze_notes_path(article,
                                  format: :turbo_stream,
                                  cloze_note: { sentence: },
                                  ordinal_position:),
         headers: { "Turbo-Frame": turbo_id }
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:sentence) { "The {{c1::neuroplasticity}}." }
  let(:ordinal_position) { 0 }
  let(:turbo_id) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"

    context "when Turbo-Frame header is present" do
      let(:turbo_id) { Note.ordinal_position_zero_turbo_dom_id }

      it "creates a cloze note" do
        expect { post_cloze_notes_create }.to change(ClozeNote, :count).by(1)
        expect(article.cloze_notes.count).to eq 1
      end

      context "when sentence param is blank" do
        let(:sentence) { "   " }

        it "does not create a cloze note" do
          expect { post_cloze_notes_create }.not_to change(ClozeNote, :count)
          expect(flash[:alert]).to include "Sentence can't be blank"
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
