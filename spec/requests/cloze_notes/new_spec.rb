# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /articles/:article_id/cloze_notes/new", "#new" do
  subject(:get_cloze_notes_new) { get new_article_cloze_note_path(article), headers: }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:headers) { { "Turbo-Frame": turbo_id } }
  let(:turbo_id) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"

    context "when the Turbo-Frame header is present" do
      let(:turbo_id) { Note.ordinal_position_zero_turbo_dom_id }

      it "returns a successful response" do
        get_cloze_notes_new
        expect(response).to have_http_status(:success)
      end

      context "when article has a note already and making a new one after it" do
        before do
          create(:basic_note, article:, ordinal_position: 0)
        end

        let(:turbo_id) { article.notes.find_by(ordinal_position: 0).new_next_note_sibling_after_note_turbo_id }

        it "returns a successful response" do
          get_cloze_notes_new
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
