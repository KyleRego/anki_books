# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Articles" do
  describe "POST /articles/:article_id/change_note_ordinal_position" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      include_context "when the user is logged in"

      context "when the book belongs to the user" do
        let(:book) { create(:book, users: [user]) }
        let(:article) { create(:article, book:) }
        let!(:note_a) { create(:basic_note, article:) }
        let!(:note_b) { create(:basic_note, article:) }
        let!(:note_c) { create(:basic_note, article:) }

        # rubocop:disable RSpec/MultipleExpectations
        it "changes the ordinal_position of the note and shifts the other notes" do
          post change_article_note_ordinal_position_path(article),
               params: { note_id: note_a.id, new_ordinal_position: 2 }
          expect(note_a.reload.ordinal_position).to eq 2
          expect(note_b.reload.ordinal_position).to eq 0
          expect(note_c.reload.ordinal_position).to eq 1
        end
        # rubocop:enable RSpec/MultipleExpectations

        it "returns a 422 response if the new_ordinal_position param is negative" do
          post change_article_note_ordinal_position_path(article),
               params: { note_id: note_a.id, new_ordinal_position: -1 }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "returns a 422 response if the new_ordinal_position param is the number of notes the article has" do
          post change_article_note_ordinal_position_path(article),
               params: { note_id: note_a.id, new_ordinal_position: article.notes_count }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "returns a 422 response if the new_ordinal_position param is the old ordinal_position of the note" do
          post change_article_note_ordinal_position_path(article),
               params: { note_id: note_a.id, new_ordinal_position: note_a.ordinal_position }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

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
    end

    it "redirects to the homepage if the user is not logged in" do
      article = create(:article)
      post change_article_note_ordinal_position_path(article), params: { note_id: "asdf", new_ordinal_position: 2 }
      expect(response).to redirect_to root_path
    end
  end
end
