# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe BasicNote, "#url" do
  subject(:url) { basic_note.url }

  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }
  let(:content) { "anchor_tag_content" }

  it "returns a URL with the article path and basic note turbo ID in the URL" do
    expect(url).to include "/articles/#{article.id}##{basic_note.turbo_id}"
  end
end
