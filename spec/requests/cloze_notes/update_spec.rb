# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /articles/:article_id/cloze_notes/:id", "#update" do
  subject(:patch_cloze_notes_update) do
    patch article_cloze_note_path(article, cloze_note), params:, headers:
  end

  let(:params) { { cloze_note: { sentence: new_sentence } } }
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:cloze_note) { create(:cloze_note, article:) }
  let(:new_sentence) { "A new {{c1::cloze}} note sentence." }
  let(:headers) { { "Turbo-Frame": cloze_note.turbo_dom_id } }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "updates the cloze note" do
      patch_cloze_notes_update
      expect(cloze_note.reload.sentence).to eq new_sentence
    end

    context "when sentence param is blank" do
      let(:new_sentence) { "   " }

      it "does not update the cloze note" do
        patch_cloze_notes_update
        expect(cloze_note.sentence).not_to be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the Turbo-Frame header is missing" do
      let(:headers) { nil }

      include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"
    end

    context "when cloze note belongs to a book that does not belong to user" do
      let(:book) { create(:book, users: []) }

      it "redirects to the homepage" do
        patch_cloze_notes_update
        expect(response).to redirect_to root_path
      end
    end

    context "when cloze note does not exist" do
      before { cloze_note.destroy }

      it "redirects to the homepage" do
        patch_cloze_notes_update
        expect(response).to redirect_to root_path
      end
    end
  end
end
