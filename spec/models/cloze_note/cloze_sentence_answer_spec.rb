# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#cloze_sentence_answer" do
  subject(:cloze_sentence_answer) { cloze_note.cloze_sentence_answer }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:cloze_note) { create(:cloze_note, article:, cloze_text:) }
  let(:cloze_text) { "hello {{c1::world}}." }

  it "returns the sentence with {{ci::abc}} removed showing abc" do
    expect(cloze_sentence_answer).to eq "hello world."
  end

  context "when sentence has multiple {{ci::}}" do
    let(:cloze_text) { "{{c1::hello}} world is the {{c2::first}} {{c3::program}}. Written {{c1::usually}}." }

    it "returns the sentence with all {{ci::abc}} removed showing abc" do
      expect(cloze_sentence_answer).to eq "hello world is the first program. Written usually."
    end
  end
end
