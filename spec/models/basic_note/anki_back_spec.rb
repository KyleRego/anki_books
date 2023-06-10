# frozen_string_literal: true

require "rails_helper"

RSpec.describe BasicNote, "#anki_back" do
  let(:article) { create(:article) }

  it "replaces newline characters with HTML linebreaks" do
    basic_note = build(:basic_note, article:)
    basic_note.back = "hello\nworld"
    expect(basic_note.anki_back).to eq("hello<br>world")
  end

  it "replaces HTML characters with HTML entities" do
    basic_note = build(:basic_note, article:)
    basic_note.back = "What is a <turbo-frame>?"
    expect(basic_note.anki_back).to eq("What is a &lt;turbo-frame&gt;?")
  end

  it "replaces HTML characters with HTML entities and replaces newline characters with HTML linebreaks" do
    basic_note = build(:basic_note, article:)
    basic_note.back = "hello\nworld\nWhat is a <turbo-frame>?"
    expect(basic_note.anki_back).to eq("hello<br>world<br>What is a &lt;turbo-frame&gt;?")
  end
end
