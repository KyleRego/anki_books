# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /update_anki_deck", "#update_anki_deck" do
  subject(:get_users_update_anki_deck) { get user_update_anki_deck_path }

  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a redirect to downloads" do
      get_users_update_anki_deck
      expect(flash[:notice]).not_to be_empty
      expect(response).to redirect_to downloads_path
    end
  end
end
