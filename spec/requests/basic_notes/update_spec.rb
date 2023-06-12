# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "BasicNotes" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "PATCH /articles/:article_id/basic_notes/:id" do
    it "sends a 403 Forbidden response if the Turbo-Frame header is missing" do
      get article_basic_note_path(article, basic_note)
      expect(response).to have_http_status :forbidden
    end

    # rubocop:disable RSpec/MultipleExpectations
    context "when user is logged in" do
      include_context "when the user is logged in"

      it "updates the Basic note" do
        patch article_basic_note_path(article, basic_note, basic_note: { front: "new front", back: "new back" }),
              headers: { "Turbo-Frame": turbo_id_for_basic_note(basic_note) }
        expect(basic_note.reload.front).to eq "new front"
        expect(basic_note.back).to eq "new back"
      end
    end

    it "does not update the Basic note if the user is not logged in" do
      patch article_basic_note_path(article, basic_note, basic_note: { front: "new front", back: "new back" }),
            headers: { "Turbo-Frame": turbo_id_for_basic_note(basic_note) }
      expect(basic_note.reload.front).not_to eq "new front"
      expect(basic_note.back).not_to eq "new back"
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
