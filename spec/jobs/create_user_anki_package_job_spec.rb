# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe CreateUserAnkiPackageJob do
  describe ".perform" do
    subject(:create_user_anki_deck) { described_class.perform_now(user:) }

    include_context "when the user has two books, three articles, 5 basic notes per article"

    let(:anki_deck_file_path) { subject }

    after { FileUtils.rm_f(anki_deck_file_path) }

    it "creates an Anki deck zip file in the system tmp directory" do
      create_user_anki_deck
      expect(File).to exist(anki_deck_file_path)
    end

    it "returns a path to the Anki deck zip file it creates" do
      create_user_anki_deck
      expect(anki_deck_file_path).to match(described_class.path_to_anki_package_regex)
    end

    context "when article content has 6 cloze notes for 3 concepts where 2 already exist" do
      before do
        book = create(:book, users: [user])
        content = "The {{c1::nervous system}}. {{c2::brain}}. Thinking {{c3::brain}} time."
        content += " There is a {{c1::neuron}}. The {{c1::brain}} has a {{c2::neuron}}."
        content += " One {{c2::brain}} per {{c1::nervous system}}."
        create(:article, book:, content:)
        create(:concept, user:, name: "nervous system")
        create(:concept, user:, name: "neuron")
      end

      it "creates the missing concept" do
        expect { create_user_anki_deck }.to change(Concept, :count).by(1)
      end

      it "creates the user's cloze notes" do
        expect { create_user_anki_deck }.to change(ClozeNote, :count).by(6)
      end

      it "creates an Anki deck zip file in the system tmp directory" do
        create_user_anki_deck
        expect(File).to exist(anki_deck_file_path)
      end
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
