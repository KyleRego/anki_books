# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe BasicNote, "#anki_back" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  let(:article_id) { article.id }
  let(:turbo_id) { basic_note.turbo_dom_id }

  it "replaces newline characters with HTML linebreaks" do
    basic_note.back = "hello\nworld"
    expect(basic_note.anki_back).to start_with("hello<br>world")
  end

  it "replaces HTML characters with HTML entities" do
    basic_note.back = "What is a <turbo-frame>?"
    expect(basic_note.anki_back).to start_with("What is a &lt;turbo-frame&gt;?")
  end

  it "replaces HTML characters with HTML entities and replaces newline characters with HTML linebreaks" do
    basic_note.back = "hello\nworld\nWhat is a <turbo-frame>?"
    expect(basic_note.anki_back).to start_with("hello<br>world<br>What is a &lt;turbo-frame&gt;?")
  end
end
