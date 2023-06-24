# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_is_unauthorized"

RSpec.describe "PATCH /articles/:id/transfer_basic_notes", "#transfer_basic_notes" do
  subject(:patch_articles_transfer_basic_notes) do
    params = { target_article_id: target_article.id, basic_note_ids: }
    patch article_transfer_basic_notes_path(article), params:
  end

  let(:article) { create(:article) }
  let(:target_article) { create(:article) }
  let(:basic_note_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article's book does not belong to the user" do
      patch_articles_transfer_basic_notes
      expect(response).to redirect_to(root_path)
    end

    context "when the article's book belongs to the user" do
      let(:book) { create(:book, users: [user]) }
      let(:article) do
        article = create(:article, book:)
        create_list(:basic_note, 10, article:)
        article
      end

      let(:basic_note_ids) { article.basic_notes.first(5).map(&:id) }

      context "when the target article belongs to the user" do
        let(:target_article) { create(:article, book:) }

        it "redirects to the manage article page and moves the basic notes to target article" do
          patch_articles_transfer_basic_notes
          expect(response).to redirect_to(manage_article_path(article))
          expect(article.basic_notes.pluck(:ordinal_position)).to eq [0, 1, 2, 3, 4]
          expect(target_article.basic_notes.count).to eq 5
          expect(target_article.basic_notes.pluck(:id).sort).to eq basic_note_ids.sort
        end

        context "when the basic_note_ids param has only ids of basic notes from a different article" do
          let(:basic_note_ids) do
            article = create(:article)
            create_list(:basic_note, 3, article:).map(&:id)
          end

          it "redirects to the manage article page but does not move any basic notes" do
            patch_articles_transfer_basic_notes
            expect(response).to redirect_to(manage_article_path(article))
            expect(article.basic_notes.count).to eq 10
          end
        end

        context "when the basic_note_ids param has some but not all ids of basic notes from a different article" do
          let(:valid_basic_note_ids) { article.basic_notes.first(6).map(&:id) }
          let(:invalid_basic_note_ids) do
            article = create(:article)
            create_list(:basic_note, 3, article:).map(&:id)
          end
          let(:basic_note_ids) { valid_basic_note_ids + invalid_basic_note_ids }

          it "redirects to the manage article page and moves only the basic notes from the article" do
            patch_articles_transfer_basic_notes
            expect(response).to redirect_to(manage_article_path(article))
            expect(article.basic_notes.pluck(:ordinal_position)).to eq [0, 1, 2, 3]
            expect(target_article.basic_notes.count).to eq 6
            expect(target_article.basic_notes.pluck(:id).sort).to eq valid_basic_note_ids.sort
          end
        end
      end

      context "when the target article does not belong to the user"
      it "redirects to the homepage" do
        patch_articles_transfer_basic_notes
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
