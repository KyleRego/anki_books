# frozen_string_literal: true

RSpec.describe CreateUserAnkiDeck do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:anki_deck_file_path) { described_class.perform(user:) }

  before do
    5.times { create(:basic_note, article:) }
    anki_deck_file_path
  end

  after do
    FileUtils.rm_f(anki_deck_file_path)
  end

  it "creates an Anki deck zip file in the system tmp directory" do
    expect(File).to exist(anki_deck_file_path)
  end

  it "returns a path to the Anki deck zip file it creates" do
    expect(anki_deck_file_path).to match(%r{\A/tmp/anki_books_package_\d+.apkg\z})
  end
end
