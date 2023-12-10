# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Note, ".new_ordinal_position_zero_note_turbo_id" do
  subject(:new_ordinal_position_zero_note_turbo_id) do
    described_class.new_ordinal_position_zero_note_turbo_id
  end

  it "returns a constant string" do
    expect(new_ordinal_position_zero_note_turbo_id).to eq "article-first-new-note"
  end
end
