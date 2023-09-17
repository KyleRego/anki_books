# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#basic_notes_count" do
  it "returns the number of notes the article has" do
    article = create(:article)
    create_list(:basic_note, 3, article:)
    expect(article.basic_notes_count).to eq 3
  end
end
