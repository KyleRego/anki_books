# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#anki_back_extra" do
  subject(:anki_back_extra) { cloze_note.anki_back_extra }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  let(:cloze_note) do
    concept = create(:concept, user:, name: "brain")
    sentence = "The brain decides the next action in the current plan."
    create(:cloze_note, article:, sentence:, concepts: [concept])
  end

  it "includes a link back to the article" do
    expect(cloze_note.anki_back_extra).to include("/articles/#{article.id}\">Anki Books</a>")
  end

  it "includes a last downloaded at timestamp" do
    expect(cloze_note.anki_back_extra).to include("<br>Downloaded from")
    expect(cloze_note.anki_back_extra).to include(DateTime.current.strftime("%b %d"))
  end
end
