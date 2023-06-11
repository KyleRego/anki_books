# frozen_string_literal: true

RSpec.describe "Articles" do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let!(:note_a) { create(:basic_note, article:) }
  let!(:note_b) { create(:basic_note, article:) }
  let!(:note_c) { create(:basic_note, article:) }

  describe "POST /articles/:article_id/change_note_ordinal_position" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it "changes the ordinal_position of the note and shifts the other notes" do
        post change_article_note_ordinal_position_path(article), params: { note_id: note_a.id, new_ordinal_position: 2 }
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

    it "redirects if the user is not logged in" do
      post change_article_note_ordinal_position_path(article), params: { note_id: note_a.id, new_ordinal_position: 2 }
      expect(response).to have_http_status(:found)
    end
  end
end
