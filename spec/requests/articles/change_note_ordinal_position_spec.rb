# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /articles/:id/change_note_ordinal_position", "#change_note_ordinal_position" do
  subject(:post_articles_change_note_ordinal_position) do
    post change_article_note_ordinal_position_path(target_article),
         params: { note_id: note_to_move.id, new_ordinal_position: }
  end

  let(:target_article) { create(:article, book:) }
  let(:note_to_move) { create(:basic_note, article: target_article) }
  let(:book) { create(:book) }

  let(:new_ordinal_position) { nil }

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

    context "when the article belongs to the user's book and is the note's current article" do
      let(:book) { create(:book, users: [user]) }
      let(:note_to_move) { note_a }
      let!(:note_a) { create(:basic_note, article: target_article) }
      let!(:note_b) { create(:basic_note, article: target_article) }
      let!(:note_c) { create(:basic_note, article: target_article) }
      let(:new_ordinal_position) { 2 }

      it "changes the ordinal_position of the note and shifts the other notes" do
        post_articles_change_note_ordinal_position
        expect(note_a.reload.ordinal_position).to eq new_ordinal_position
        expect(note_b.reload.ordinal_position).to eq 0
        expect(note_c.reload.ordinal_position).to eq 1
      end

      context "when the desired new_ordinal_position is negative" do
        let(:new_ordinal_position) { -1 }

        it "returns a 422 response" do
          post_articles_change_note_ordinal_position
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when the desired new_ordinal_position is the number of notes the article has" do
        let(:new_ordinal_position) { target_article.basic_notes_count }

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

    context "when the article belongs to the user's book and is not the note's current article" do
      let(:book) { create(:book, users: [user]) }
      let(:original_article) { create(:article, book:) }
      let(:note_to_move) { create(:basic_note, article: original_article) }
      let(:target_article) { create(:article, book:) }

      context "when the note does not belong to the user" do
        let(:note_to_move) do
          create(:basic_note, article: create(:article, book: create(:book)))
        end

        it "returns a 422 response" do
          post_articles_change_note_ordinal_position
          expect(response).to have_http_status :unprocessable_entity
        end
      end

      context "when it is the only note in both articles" do
        let(:new_ordinal_position) { 0 }

        it "moves the note to the target article" do
          post_articles_change_note_ordinal_position
          expect(note_to_move.reload.article).to eq target_article
        end
      end

      context "when both articles have 5 notes" do
        before do
          create_list(:basic_note, 5, article: original_article)
          create_list(:basic_note, 5, article: target_article)
        end

        let(:note_to_move) { original_article.basic_notes.find_by(ordinal_position: 2) }

        context "when it is moved to be the first note of the target article" do
          let(:new_ordinal_position) { 0 }

          it "moves the first article's note to the target article correctly" do
            post_articles_change_note_ordinal_position
            expect(note_to_move.reload.article).to eq target_article
            expect(note_to_move.ordinal_position).to eq new_ordinal_position
            expect(original_article.basic_notes.reload.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
            expect(target_article.basic_notes.reload.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3, 4, 5]
          end
        end

        context "when it is moved to be the middle note of the target article" do
          let(:new_ordinal_position) { 2 }

          it "moves the first article's note to the target article correctly" do
            post_articles_change_note_ordinal_position
            expect(note_to_move.reload.article).to eq target_article
            expect(note_to_move.ordinal_position).to eq new_ordinal_position
            expect(original_article.basic_notes.reload.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
            expect(target_article.basic_notes.reload.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3, 4, 5]
          end
        end

        context "when it is moved to be the last note of the target article" do
          let(:new_ordinal_position) { 4 }

          it "moves the first article's note to the target article correctly" do
            post_articles_change_note_ordinal_position
            expect(note_to_move.reload.article).to eq target_article
            expect(note_to_move.ordinal_position).to eq new_ordinal_position
            expect(original_article.basic_notes.reload.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3]
            expect(target_article.basic_notes.reload.pluck(:ordinal_position).sort).to eq [0, 1, 2, 3, 4, 5]
          end
        end
      end
    end
  end
end
