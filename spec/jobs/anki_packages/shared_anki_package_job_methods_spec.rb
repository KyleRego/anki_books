# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe AnkiPackages::SharedAnkiPackageJobMethods do
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
