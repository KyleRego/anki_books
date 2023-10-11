# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#url" do
  subject(:url) { cloze_note.url }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  let(:cloze_note) do
    concept = create(:concept, user:, name: "brain")
    sentence = "The brain decides the next action in the current plan."
    create(:cloze_note, article:, sentence:, concepts: [concept])
  end

  it "returns a URL with the article path" do
    expect(url).to include("/articles/#{article.id}")
  end
end
