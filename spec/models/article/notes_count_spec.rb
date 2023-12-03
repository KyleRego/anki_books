# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#notes_count" do
  subject(:notes_count) do
    article.notes_count
  end

  let(:article) { create(:article) }

  context "when article has just 3 basic notes" do
    before { create_list(:basic_note, 3, article:) }

    it "returns 3" do
      expect(notes_count).to eq 3
    end
  end

  context "when article has just 4 cloze notes" do
    before { create_list(:cloze_note, 4, article:) }

    it "returns 4" do
      expect(notes_count).to eq 4
    end
  end

  context "when article has 7 basic notes and 3 cloze notes" do
    before do
      create_list(:basic_note, 3, article:)
      create_list(:cloze_note, 3, article:)
      create_list(:basic_note, 4, article:)
    end

    it "returns 10" do
      expect(notes_count).to eq 10
    end
  end
end
