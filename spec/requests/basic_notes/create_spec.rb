# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "BasicNotes" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "POST /articles/:article_id/basic_notes" do
    it "sends a 403 Forbidden response if the Turbo-Frame header is missing" do
      post article_basic_notes_path(article)
      expect(response).to have_http_status(:forbidden)
    end

    it "does not create a new Basic note if the user is not logged in and needs to be" do
      expect do
        post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 0),
             headers: { "Turbo-Frame": first_new_basic_note_turbo_id }
      end.not_to change(BasicNote, :count)
    end

    context "when user is logged in" do
      include_context "when the user is logged in"

      it "creates a new Basic note if the user is logged in" do
        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 0),
               headers: { "Turbo-Frame": first_new_basic_note_turbo_id }
        end.to change(BasicNote, :count).by(1)
      end

      it "creates a Basic note with ordinal_position 0 if it is the article's first note" do
        post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 0),
             headers: { "Turbo-Frame": first_new_basic_note_turbo_id }
        expect(article.basic_notes.first.ordinal_position).to eq 0
      end

      it "creates a Basic note with ordinal_position 1 if it is the article's second note" do
        sibling = create(:basic_note, article:)

        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 1),
               headers: { "Turbo-Frame": sibling.new_sibling_note_turbo_id }
        end.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
      end

      it "creates a Basic note between two notes that the article already has" do
        sibling = create(:basic_note, article:)
        create(:basic_note, article:)

        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: 1),
               headers: { "Turbo-Frame": sibling.new_sibling_note_turbo_id }
        end.to change(BasicNote, :count).by(1)
        expect(article.basic_notes.order(:created_at).last.ordinal_position).to eq 1
      end

      it "does not create a basic note if ordinal_position param is less than 0" do
        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }, ordinal_position: -1),
               headers: { "Turbo-Frame": first_new_basic_note_turbo_id }
        end.not_to change(BasicNote, :count)
      end

      it "does not create a basic note if the ordinal_position param is more than the article's number of notes" do
        expect do
          post article_basic_notes_path(article,
                                        basic_note: { front: "Front", back: "Back" },
                                        ordinal_position: article.notes_count + 1),
               headers: { "Turbo-Frame": first_new_basic_note_turbo_id }
        end.not_to change(BasicNote, :count)
      end
    end
  end
end
