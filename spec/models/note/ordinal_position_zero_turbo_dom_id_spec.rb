# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Note, ".ordinal_position_zero_turbo_dom_id" do
  subject(:ordinal_position_zero_turbo_dom_id) do
    described_class.ordinal_position_zero_turbo_dom_id
  end

  it "returns a constant string" do
    expect(ordinal_position_zero_turbo_dom_id).to eq "article-first-new-note"
  end
end
