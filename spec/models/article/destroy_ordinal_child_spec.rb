# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#destroy_ordinal_child" do
  subject(:destroy_ordinal_child) do
    article.destroy_ordinal_child(child: note)
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  context "when the child note to delete does not belong to the article" do
    let(:note) { create(:cloze_note, article: create(:article, book: create(:book))) }

    it "raises an ArgumentError and does not delete the article" do
      expect { destroy_ordinal_child }.to raise_error ArgumentError
      expect { note.reload }.not_to raise_error
    end
  end
end
