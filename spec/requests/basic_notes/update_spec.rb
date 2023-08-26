# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /articles/:article_id/basic_notes/:id", "#update" do
  subject(:patch_basic_notes_update) do
    patch article_basic_note_path(article, basic_note), params:, headers:
  end

  let(:params) { { basic_note: { front:, back: }, options: { on_study_cards: } } }
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }
  let(:front) { "new front" }
  let(:back) { "new back" }
  let(:headers) { { "Turbo-Frame": basic_note.turbo_id } }
  let(:on_study_cards) { false }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "updates the basic note" do
      patch_basic_notes_update
      expect(basic_note.reload.front).to eq "new front"
      expect(basic_note.back).to eq "new back"
    end

    context "when back param is nil" do
      let(:back) { nil }

      it "does not update the basic note" do
        patch_basic_notes_update
        expect(basic_note.back).not_to be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the Turbo-Frame header is missing" do
      let(:headers) { nil }

      include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"
    end
  end
end
