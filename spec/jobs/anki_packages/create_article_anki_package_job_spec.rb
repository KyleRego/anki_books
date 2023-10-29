# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe AnkiPackages::CreateArticleAnkiPackageJob do
  describe ".perform" do
    subject(:create_article_anki_deck) { described_class.perform_now(article:) }

    let(:user) { create(:user) }
    let(:book) { create(:book, users: [user]) }
    let(:article) { create(:article, book:, content:) }
    let(:content) { "" }

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

    context "when article content has 2 cloze concepts in 1 sentence" do
      let(:content) do
        "{{c2::TCP}} is a {{c1::protocol}}. UDP is a protocol. Ethernet is in the link layer. Tests."
      end

      it "creates the two concepts" do
        expect { create_article_anki_deck }.to change(Concept, :count).by(2)
      end

      it "creates one cloze note" do
        expect { create_article_anki_deck }.to change(ClozeNote, :count).by(1)
      end

      it "creates an Anki deck zip file in the system tmp directory" do
        create_article_anki_deck
        expect(File).to exist(anki_deck_file_path)
      end
    end
  end
end
