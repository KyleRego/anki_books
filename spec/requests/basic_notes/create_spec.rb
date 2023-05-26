# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotes" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "POST /articles/:article_id/basic_notes" do
    it "sends a 403 Forbidden response if the Turbo-Frame header is missing" do
      post article_basic_notes_path(article)
      expect(response).to have_http_status(:forbidden)
    end

    it "does not create a new Basic note if the user is not logged in" do
      expect do
        post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 0),
             headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling: nil) }
      end.not_to change(BasicNote, :count)
    end

    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "creates a new Basic note if the user is logged in" do
        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 0),
               headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling: nil) }
        end.to change(BasicNote, :count).by(1)
      end

      it "creates a Basic note with ordinal_position 0 if it is the article's first note" do
        post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 0),
             headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling: nil) }
        expect(article.basic_notes.first.ordinal_position).to eq 0
      end

      it "creates a Basic note with ordinal_position 1 if it is the article's second note" do
        sibling = create(:basic_note, article:)

        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 1),
               headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling:) }
        end.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
      end

      it "creates a Basic note between two notes that the article already has" do
        sibling = create(:basic_note, article:)
        create(:basic_note, article:)

        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 1),
               headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling:) }
        end.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
      end

      it "returns a 422 response if the ordinal_position param is less than 0" do
        post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: -1),
             headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a 422 response if the ordinal_position param is more than the article's number of notes" do
        post article_basic_notes_path(article,
                                      basic_note: { front: "Front", back: "Back" },
                                      ordinal_position: article.notes_count + 1),
             headers: { "Turbo-Frame": turbo_id_for_new_basic_note(sibling: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
