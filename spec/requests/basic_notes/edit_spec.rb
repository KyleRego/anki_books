# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /articles/:article_id/basic_notes/:id/edit", "#edit" do
  subject(:get_basic_notes_edit) { get edit_article_basic_note_path(article, basic_note), headers: }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:basic_note) { create(:basic_note, article:) }
  let(:headers) { { "Turbo-Frame": basic_note.turbo_id } }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns successful" do
      get_basic_notes_edit
      expect(response).to have_http_status(:success)
    end

    context "when the Turbo-Frame header is missing" do
      let(:headers) { nil }

      include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"
    end
  end
end
