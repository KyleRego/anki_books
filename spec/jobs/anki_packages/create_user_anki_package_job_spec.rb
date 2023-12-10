# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe AnkiPackages::CreateUserAnkiPackageJob do
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
      expect(anki_deck_file_path).to match(AnkiPackages::SharedAnkiPackageJobMethods.path_to_anki_package_regex)
    end

    context "when user has a two articles, two books, one book is the other's parent book" do
      before do
        parent_book = create(:book, users: [user])
        child_book = create(:book, users: [user], parent_book_id: parent_book.id)
        parent_book_article = create(:article, book: parent_book)
        child_book_article = create(:article, book: child_book)

        create_list(:basic_note, 2, article: parent_book_article)
        create_list(:cloze_note, 2, article: child_book_article)

        create_list(:basic_note, 2, article: parent_book_article)
        create_list(:cloze_note, 2, article: child_book_article)
      end

      it "creates an Anki deck zip file in the system tmp directory" do
        create_user_anki_deck
        expect(File).to exist(anki_deck_file_path)
      end
    end
  end
end
