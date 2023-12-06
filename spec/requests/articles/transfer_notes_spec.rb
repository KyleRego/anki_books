# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# TODO: Needs some refactoring
RSpec.describe "PATCH /articles/:id/transfer_notes", "#transfer_notes" do
  subject(:patch_articles_transfer_notes) do
    params = { target_article_id: target_article.id, note_ids: }
    patch article_transfer_notes_path(article), params:
  end

  let(:article) { create(:article) }
  let(:target_article) { create(:article) }
  let(:note_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article's book does not belong to the user" do
      patch_articles_transfer_notes
      expect(response).to redirect_to(root_path)
    end

    context "when the article's book belongs to the user" do
      let(:book) { create(:book, users: [user]) }
      let(:article) do
        article = create(:article, book:)
        create_list(:basic_note, 10, article:)
        article
      end

      let(:note_ids) { article.basic_notes.first(5).map(&:id) }

      it "redirects to the homepage if the target article does not belong to the user" do
        patch_articles_transfer_notes
        expect(response).to redirect_to(root_path)
      end

      context "when the target article belongs to one of the user's other books" do
        let(:target_article) do
          book = create(:book, users: [user])
          create(:article, book:)
        end

        it "returns the not found redirect" do
          patch_articles_transfer_notes
          expect(response).to redirect_to root_path
        end
      end

      context "when the target article belongs to the same book" do
        let(:target_article) { create(:article, book:) }

        it "redirects to the manage article page and moves the basic notes to target article" do
          patch_articles_transfer_notes
          expect(response).to redirect_to(manage_article_path(article))
          expect(article.correct_children_ordinal_positions?).to be true
          expect(target_article.basic_notes.count).to eq 5
          expect(target_article.basic_notes.pluck(:id).sort).to eq note_ids.sort
        end

        context "when the note_ids param has only ids of basic notes from a different article" do
          let(:note_ids) do
            article = create(:article)
            create_list(:basic_note, 3, article:).map(&:id)
          end

          it "returns a 422 response" do
            patch_articles_transfer_notes
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end

        context "when the note_ids param has some but not all ids of basic notes from a different article" do
          let(:valid_note_ids) { article.basic_notes.first(6).map(&:id) }
          let(:invalid_note_ids) do
            article = create(:article)
            create_list(:basic_note, 3, article:).map(&:id)
          end
          let(:note_ids) { valid_note_ids + invalid_note_ids }

          it "redirects to the manage article page and moves only the basic notes from the article" do
            patch_articles_transfer_notes
            expect(response).to redirect_to(manage_article_path(article))
            expect(article.correct_children_ordinal_positions?).to be true
            expect(target_article.basic_notes.count).to eq 6
            expect(target_article.basic_notes.pluck(:id).sort).to eq valid_note_ids.sort
          end
        end
      end
    end
  end
end
