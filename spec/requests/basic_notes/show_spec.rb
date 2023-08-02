# frozen_string_literal: true

require_relative "../../support/shared_examples/missing_turboframe_header_forbidden"

RSpec.describe "GET /articles/:article_id/basic_notes/:id", "#show" do
  subject(:get_basic_notes_show) { get article_basic_note_path(article, basic_note) }

  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"
end
