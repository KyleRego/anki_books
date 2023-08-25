# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /articles/:id/change_note_ordinal_position", "#change_note_ordinal_position" do
  subject(:post_articles_change_note_ordinal_position) do
    post change_article_note_ordinal_position_path(article),
         params: { note_id: note_a.id, new_ordinal_position: }
  end

  let(:article) { create(:article, book:) }
  let(:book) { create(:book) }
  let!(:note_a) { create(:basic_note, article:) }
  let!(:note_b) { create(:basic_note, article:) }
  let!(:note_c) { create(:basic_note, article:) }
  let(:new_ordinal_position) { 2 }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    context "when the article does not belong to one of the user's books" do
      let(:book_unrelated_to_user) { create(:book) }
      let(:article_unrelated_to_user) { create(:article, book: book_unrelated_to_user) }
      let!(:note_a) { create(:basic_note, article: article_unrelated_to_user) }
      let!(:note_b) { create(:basic_note, article: article_unrelated_to_user) }

      it "redirects if the article does not belong to one of the user's books" do
        post change_article_note_ordinal_position_path(article_unrelated_to_user),
             params: { note_id: note_a.id, new_ordinal_position: 1 }
        expect(response).to redirect_to root_path
      end
    end

    context "when the article belongs to the user's book" do
      let(:book) { create(:book, users: [user]) }

      it "changes the ordinal_position of the note and shifts the other notes" do
        post_articles_change_note_ordinal_position
        expect(note_a.reload.ordinal_position).to eq new_ordinal_position
        expect(note_b.reload.ordinal_position).to eq 0
        expect(note_c.reload.ordinal_position).to eq 1
      end
      # rubocop:enable RSpec/MultipleExpectations

      context "when the desired new_ordinal_position is negative" do
        let(:new_ordinal_position) { -1 }

        it "returns a 422 response" do
          post_articles_change_note_ordinal_position
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the desired new_ordinal_position is the number of notes the article has" do
        let(:new_ordinal_position) { article.notes_count }

        it "returns a 422 response" do
          post_articles_change_note_ordinal_position
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the desired new_ordinal_position is the ordinal position that the note has already" do
        let(:new_ordinal_position) { note_a.ordinal_position }

        it "returns a 200 response" do
          post_articles_change_note_ordinal_position
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
