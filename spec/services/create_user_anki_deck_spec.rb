# frozen_string_literal: true

require_relative "../support/shared_contexts/user_with_articles_books_and_notes"

RSpec.describe CreateUserAnkiDeck do
  describe ".perform" do
    subject(:create_user_anki_deck) { described_class.perform(user:) }

    include_context "when the user has two books, three articles, 5 basic notes per article"

    let(:anki_deck_file_path) { subject }

    before { create_user_anki_deck }

    after { FileUtils.rm_f(anki_deck_file_path) }

    it "creates an Anki deck zip file in the system tmp directory" do
      expect(File).to exist(anki_deck_file_path)
    end

    it "returns a path to the Anki deck zip file it creates" do
      expect(anki_deck_file_path).to match(%r{\A/tmp/anki_books_package_\d+.apkg\z})
    end
  end
end
