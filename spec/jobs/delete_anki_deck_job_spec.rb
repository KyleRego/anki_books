# frozen_string_literal: true

require "rails_helper"

RSpec.describe DeleteAnkiDeckJob do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  it "throws an error if the path is not to an anki package file" do
    expect { described_class.perform_now(anki_deck_file_path: "invalid") }.to raise_error(ArgumentError)
  end

  context "when there is an Anki deck file to delete" do
    let(:anki_deck_file_path) { CreateUserAnkiDeck.perform(user:) }

    before { anki_deck_file_path }

    it "deletes the Anki deck file" do
      described_class.perform_now(anki_deck_file_path:)
      expect(File).not_to exist(anki_deck_file_path)
    end
  end
end
