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

    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "creates a new Basic note" do
        expect do
          post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }),
               headers: { "Turbo-Frame": turbo_frame_for_new_basic_note }
        end.to change(BasicNote, :count).by(1)
      end
    end

    it "does not create a new Basic note if the user is not logged in" do
      expect do
        post article_basic_notes_path(article, basic_note: { front: "Front", back: "Back" }),
             headers: { "Turbo-Frame": turbo_frame_for_new_basic_note }
      end.not_to change(BasicNote, :count)
    end
  end
end
