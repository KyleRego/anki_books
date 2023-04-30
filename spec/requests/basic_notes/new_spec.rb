# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotes" do
  let(:article) { create(:article) }

  describe "GET /articles/:article_id/basic_notes/new" do
    it "sends a 403 Forbidden response if the Turbo-Frame header is missing" do
      get new_article_basic_note_path(article)
      expect(response).to have_http_status :forbidden
    end
  end
end
