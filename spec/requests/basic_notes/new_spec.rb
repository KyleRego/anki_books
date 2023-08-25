# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /articles/:article_id/basic_notes/new", "#new" do
  subject(:get_basic_notes_new) { get new_article_basic_note_path(article), headers: }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:headers) { { "Turbo-Frame": turbo_id } }
  let(:turbo_id) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"

    context "when the Turbo-Frame header is for a basic note at the first position" do
      let(:turbo_id) { BasicNote::TurboFrameable::TURBO_FIRST_NEW_BASIC_NOTE_ID }

      it "returns a successful response" do
        get_basic_notes_new
        expect(response).to have_http_status(:success)
      end
    end

    context "when the Turbo-Frame header is the new_sibling_note_turbo_id of the previous sibling" do
      let(:previous_sibling) { create(:basic_note, article:) }
      let(:turbo_id) { previous_sibling.new_sibling_note_turbo_id }

      it "returns a successful response" do
        get_basic_notes_new
        expect(response).to have_http_status(:success)
      end
    end
  end
end
