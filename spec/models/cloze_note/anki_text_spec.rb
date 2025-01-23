# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#anki_text" do
  subject(:anki_text) { cloze_note.anki_text }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  let(:cloze_note) do
    concept = create(:concept, user:, name: "brain")
    create(:cloze_note, article:, cloze_text:, concepts: [concept])
  end

  context "when sentence has no special content" do
    let(:cloze_text) { "The {{c1::brain}} decides the next action in the current plan." }

    it "returns the sentence unchanged" do
      expect(anki_text).to eq cloze_text
    end
  end

  context "when sentence contains HTML characters" do
    let(:cloze_text) { "The <p>paragraph</p> is an example of {{c1::HTML}}." }

    it "escapes the HTML" do
      expect(anki_text).to eq "The &lt;p&gt;paragraph&lt;/p&gt; is an example of {{c1::HTML}}."
    end
  end

  context "when sentence has {{c1::DbSet<T>}}" do
    let(:cloze_text) { "The {{c1::DbSet<T>}} is the ... table (test data!)." }

    it "escapes the < and >" do
      expect(anki_text).to eq "The {{c1::DbSet&lt;T&gt;}} is the ... table (test data!)."
    end
  end
end
