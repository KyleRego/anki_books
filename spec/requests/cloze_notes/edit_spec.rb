# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /articles/:article_id/cloze_notes/edit", "#edit" do
  subject(:get_cloze_notes_edit) { get edit_article_cloze_note_path(article, cloze_note), headers: }

  include ClozeNotesHelper

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:cloze_note) { create(:cloze_note, article:) }
  let(:headers) { { "Turbo-Frame": cloze_note.turbo_id } }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns successful" do
      get_cloze_notes_edit
      expect(response).to have_http_status(:success)
    end

    context "when the Turbo-Frame header is missing" do
      let(:headers) { nil }

      include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"
    end

    context "when cloze note belongs to a book that does not belong to user" do
      let(:book) { create(:book, users: []) }

      it "redirects to the homepage" do
        get_cloze_notes_edit
        expect(response).to redirect_to root_path
      end
    end
  end
end
