# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Domain, "#valid?" do
  it "is valid with a title" do
    domain = build(:domain, title: "Example Title", user: create(:user))
    expect(domain).to be_valid
  end

  it "is invalid without a user" do
    domain = build(:domain, title: "Example Title", user: nil)
    expect(domain).not_to be_valid
  end

  it "is invalid with an empty string title" do
    domain = build(:domain, title: "", user: create(:user))
    expect(domain).to be_invalid
  end

  it "is invalid without a title" do
    domain = build(:domain, title: nil, user: create(:user))
    expect(domain).to be_invalid
  end
end
