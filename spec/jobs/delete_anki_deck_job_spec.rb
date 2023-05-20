# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe DeleteAnkiDeckJob do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:target_directory) { Dir.pwd }
  let(:anki_deck_name) { "test_deck" }
  let(:anki_deck_file_path) { "#{target_directory}/#{anki_deck_name}.apkg" }

  before do
    FileUtils.rm_f(anki_deck_file_path)
  end

  it "deletes the Anki deck file" do
    CreateUserAnkiDeck.perform(user:, anki_deck_name:, target_directory:)
    described_class.perform_now(anki_deck_file_path:)
    expect(File).not_to exist(anki_deck_file_path)
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
