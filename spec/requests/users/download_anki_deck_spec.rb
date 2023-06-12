# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

require "rails_helper"

RSpec.describe "Users" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:book1) { create(:book) }
  let(:article) { create(:article, book: book1) }

  describe "GET /users/:id/download_anki_deck" do
    it "redirects to the root page if user is not logged in" do
      get user_download_anki_deck_path(user)
      expect(response).to redirect_to(root_path)
    end

    context "when user is logged in" do
      include_context "when the user is logged in"
      before do
        fixture_path = "./spec/fixtures/anki_package.apkg"
        allow(CreateUserAnkiDeck).to receive(:perform).and_return(fixture_path)
      end

      it "returns a success response" do
        assert_enqueued_with(job: DeleteAnkiDeckJob, args: [{ anki_deck_file_path: fixture_path }]) do
          DeleteAnkiDeckJob.set(wait: 3.minutes).perform_later(anki_deck_file_path: fixture_path)
        end
        get user_download_anki_deck_path(user)
        expect(response).to be_successful
      end
    end
  end
end
