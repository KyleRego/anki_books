# frozen_string_literal: true

require_relative "../../support/shared_examples/missing_turboframe_header_forbidden"
require_relative "../../support/shared_examples/not_logged_in_user_redirected_to_root"

RSpec.describe "GET /articles/:article_id/basic_notes/:id/edit", "#edit" do
  subject(:get_basic_notes_edit) { get edit_article_basic_note_path(article, basic_note), headers: }

  include BasicNotesHelper

  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }
  let(:headers) { {} }

  include_examples "request missing the Turbo-Frame header is forbidden"

  context "when the Turbo-Frame header is present" do
    let(:headers) { { "Turbo-Frame": basic_note.turbo_id } }

    include_examples "user not logged in gets redirected"
  end
end
