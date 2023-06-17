# frozen_string_literal: true

require_relative "../../support/shared_examples/missing_turboframe_header_forbidden"

RSpec.describe "GET /articles/:article_id/basic_notes/new", "#new" do
  subject(:get_basic_notes_new) { get new_article_basic_note_path(article) }

  let(:article) { create(:article) }

  include_examples "request missing the Turbo-Frame header is forbidden"
end
