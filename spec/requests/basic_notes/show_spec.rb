# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotes" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "GET /articles/:article_id/basic_notes/:id" do
    it "sends a 403 Forbidden response if the Turbo-Frame header is missing" do
      get article_basic_note_path(article, basic_note)
      expect(response).to have_http_status :forbidden
    end
  end
end
