# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "DELETE /articles/:article_id/basic_notes/:id", "#destroy" do
  subject(:basic_notes_destroy) do
    delete article_basic_note_path(article, basic_note)
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:basic_note) { article.basic_notes.take }

  before { create_list(:basic_note, 10, article:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "destroys the basic note and shifts the others to have correct ordinal positions" do
      expect { basic_notes_destroy }.to change(BasicNote, :count).by(-1)
      expect(article.correct_children_ordinal_positions?).to be true
      expect(response).to redirect_to manage_article_path(article)
    end

    context "when the basic note cannot be found for the article" do
      before { basic_note.destroy }

      it "redirects to the homepage" do
        expect { basic_notes_destroy }.not_to change(BasicNote, :count)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when article does not belong to one of the user's books" do
      let(:book) { create(:book) }

      it "redirects to the homepage" do
        expect { basic_notes_destroy }.not_to change(BasicNote, :count)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
