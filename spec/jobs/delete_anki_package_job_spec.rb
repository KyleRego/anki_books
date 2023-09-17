# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe DeleteAnkiPackageJob do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  it "throws an error if the path is not to an anki package file" do
    expect { described_class.perform_now(anki_deck_file_path: "invalid") }.to raise_error(ArgumentError)
  end

  it "throws an error is the path argument does not have the intended structure" do
    expect { described_class.perform_now(anki_deck_file_path: "/temporary/example.apkg") }.to raise_error(ArgumentError)
  end

  context "when there is an Anki deck file to delete" do
    let(:anki_deck_file_path) { CreateUserAnkiPackageJob.perform_now(user:) }

    before do
      anki_deck_file_path
      described_class.perform_now(anki_deck_file_path:)
    end

    it "deletes the Anki deck file" do
      expect(File).not_to exist(anki_deck_file_path)
    end

    it "deletes the directory in tmp that the Anki deck file was in" do
      directory_to_delete = Pathname.new(anki_deck_file_path).dirname
      expect(File).not_to exist(directory_to_delete)
    end
  end
end
