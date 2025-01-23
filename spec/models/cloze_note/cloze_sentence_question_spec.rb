# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#cloze_sentence_question" do
  subject(:cloze_sentence_question) { cloze_note.cloze_sentence_question }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:cloze_note) { create(:cloze_note, article:, cloze_text:) }
  let(:cloze_text) { "hello {{c1::world}}." }

  it "returns the cloze note's entire sentence" do
    expect(cloze_sentence_question).to eq "hello [...]."
  end

  context "when sentence has multiple {{c1::}}" do
    let(:cloze_text) do
      "Hello {{c1::world}}! I am an {{c1::Anki}} {{c2::cloze}} {{c3::deletion}} note."
    end

    it "returns a string with all {{ci::}} replaced by [...]" do
      expect(cloze_sentence_question).to eq "Hello [...]! I am an [...] [...] [...] note."
    end
  end
end
