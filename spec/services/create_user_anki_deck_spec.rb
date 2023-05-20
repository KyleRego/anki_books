# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe CreateUserAnkiDeck do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:target_directory) { Dir.pwd }
  let(:anki_deck_name) { "test_deck" }
  let(:anki_deck_file_path) { "#{target_directory}/#{anki_deck_name}.apkg" }

  before { 5.times { create(:basic_note, article:) } }

  after do
    FileUtils.rm_f(anki_deck_file_path)
  end

  it "creates an Anki deck zip file in the system tmp directory" do
    described_class.perform(user:, anki_deck_name:, target_directory:)
    expect(File).to exist(anki_deck_file_path)
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
