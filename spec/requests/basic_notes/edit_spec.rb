# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotes" do
  include BasicNotesHelper

  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "GET /articles/:article_id/basic_notes/:id/edit" do
    it "sends a 403 Forbidden response if the Turbo-Frame header is missing" do
      get edit_article_basic_note_path(article, basic_note)
      expect(response).to have_http_status :forbidden
    end

    it "redirects to the root page if user is not logged in" do
      get edit_article_basic_note_path(article, basic_note),
          headers: { "Turbo-Frame": turbo_name_for_basic_note(basic_note) }
      expect(response).to redirect_to(root_path)
    end
  end
end
