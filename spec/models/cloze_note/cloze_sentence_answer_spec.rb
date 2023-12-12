# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#cloze_sentence_answer" do
  subject(:cloze_sentence_answer) { cloze_note.cloze_sentence_answer }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:cloze_note) do
    create(:cloze_note, article:, sentence: "hello {{c1::world}}.")
  end

  it "returns the cloze note's entire sentence" do
    expect(cloze_sentence_answer).to eq cloze_note.sentence
  end
end
