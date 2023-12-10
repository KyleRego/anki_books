# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe AnkiPackages::CreateArticleAnkiPackageJob do
  describe ".perform" do
    subject(:create_article_anki_deck) { described_class.perform_now(article:) }

    let(:user) { create(:user) }
    let(:book) { create(:book, users: [user]) }
    let(:article) { create(:article, book:) }

    let(:anki_deck_file_path) { subject }

    after { FileUtils.rm_f(anki_deck_file_path) }

    it "creates an Anki deck zip file in the system tmp directory" do
      create_article_anki_deck
      expect(File).to exist(anki_deck_file_path)
    end

    it "returns a path to the Anki deck zip file it creates" do
      create_article_anki_deck
      expect(anki_deck_file_path).to match(AnkiPackages::SharedAnkiPackageJobMethods.path_to_anki_package_regex)
    end

    context "when article has basic notes and cloze notes" do
      before do
        create(:basic_note, article:, front: "Hello", back: "World")
        create(:cloze_note, article:, sentence: "Hello {{c1::world}}.")
        create(:basic_note, article:, front: "yes", back: "no")
        create(:cloze_note, article:, sentence: "Two {{c1::notes}} {{c2::here}}.")
      end

      it "creates an Anki deck zip file in the system tmp directory" do
        create_article_anki_deck
        expect(File).to exist(anki_deck_file_path)
      end
    end
  end
end
