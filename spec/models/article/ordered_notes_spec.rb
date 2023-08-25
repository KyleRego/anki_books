# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#ordered_notes" do
  it "returns the basic notes of the article in order of ordinal_position" do
    article = create(:article)
    create_list(:basic_note, 10, article:)
    expect(article.ordered_notes).to eq article.basic_notes.order(:ordinal_position)
  end
end
