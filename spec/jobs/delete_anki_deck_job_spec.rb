# frozen_string_literal: true

require "rails_helper"

RSpec.describe DeleteAnkiDeckJob do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:anki_deck_file_path) { CreateUserAnkiDeck.perform(user:) }

  before { anki_deck_file_path }

  it "deletes the Anki deck file" do
    described_class.perform_now(anki_deck_file_path:)
    expect(File).not_to exist(anki_deck_file_path)
  end
end
