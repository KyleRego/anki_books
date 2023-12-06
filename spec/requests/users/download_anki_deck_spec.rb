# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /download_anki_deck", "#download_anki_deck" do
  subject(:get_users_download_anki_deck) { get user_download_anki_deck_path }

  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"
    before do
      fixture_path = "./spec/fixtures/anki_package.apkg"
      allow(AnkiPackages::CreateUserAnkiPackageJob).to receive(:perform_now).and_return(fixture_path)
    end

    it "returns a success response" do
      assert_enqueued_with(job: DeleteAnkiPackageJob, args: [{ anki_deck_file_path: fixture_path }]) do
        DeleteAnkiPackageJob.set(wait: 3.minutes).perform_later(anki_deck_file_path: fixture_path)
      end
      get_users_download_anki_deck
      expect(response).to be_successful
    end
  end
end
