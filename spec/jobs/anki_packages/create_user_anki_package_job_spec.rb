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

      it "creates an Anki deck zip file in the system tmp directory" do
        create_user_anki_deck
        expect(File).to exist(anki_deck_file_path)
      end
    end
  end
end
