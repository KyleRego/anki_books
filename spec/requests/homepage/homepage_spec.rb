# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /", "#show" do
  before { create(:article, system: true) }

  it "shows the homepage" do
    get root_path
    expect(response).to be_successful
  end
end
