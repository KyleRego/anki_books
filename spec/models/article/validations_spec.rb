# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#valid?" do
  it "is valid with a title" do
    article = build(:article, title: "Example Title")
    expect(article).to be_valid
  end

  it "is invalid with an empty string title" do
    article = build(:article, title: "")
    expect(article).to be_invalid
  end

  it "is invalid without a title" do
    article = build(:article, title: nil)
    expect(article).to be_invalid
  end
end
