# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /articles/:article_id/basic_notes/:id", "#show" do
  subject(:get_basic_notes_show) { get article_basic_note_path(article, basic_note) }

  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  include_examples "request missing the Turbo-Frame header gets a 400 (Bad Request) response"
end
