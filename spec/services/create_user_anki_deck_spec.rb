# frozen_string_literal: true

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
      expect(anki_deck_file_path).to match(described_class.path_to_anki_package_regex)
    end
  end

  describe ".path_to_anki_package_regex" do
    it "does not match a path that clearly does not have the intended structure" do
      path = "/tmp/random"
      expect(path.match?(described_class.path_to_anki_package_regex)).to be false
    end

    it "does not match a path that almost has the intended structure" do
      path = "/tmp/1686400375479/anki_boks_package_1686400375479.apkg"
      expect(path.match?(described_class.path_to_anki_package_regex)).to be false
    end

    it "does not match a path where the first timestamp in the path has the wrong number of digits" do
      path = "/tmp/16864003754791/anki_books_package_1686400375479.apkg"
      expect(path.match?(described_class.path_to_anki_package_regex)).to be false
    end

    it "does not match a path where the second timestamp in the path has the wrong number of digits" do
      path = "/tmp/1686400375479/anki_books_package_16864003754791.apkg"
      expect(path.match?(described_class.path_to_anki_package_regex)).to be false
    end

    it "matches a path that has the exact intended structure" do
      path = "/tmp/1686400375479/anki_books_package_1686400375479.apkg"
      expect(path.match?(described_class.path_to_anki_package_regex)).to be true
    end
  end
end
