# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleExpectations
RSpec.describe BasicNote, "#anki_back" do
  let(:article) { create(:article) }

  it "replaces newline characters with HTML linebreaks" do
    basic_note = build(:basic_note, article:)
    basic_note.back = "hello\nworld"
    expect(basic_note.anki_back).to start_with("hello<br>world")
    expect(basic_note.anki_back).to end_with("/articles/#{article.id}\">Edit</a>")
  end

  it "replaces HTML characters with HTML entities" do
    basic_note = build(:basic_note, article:)
    basic_note.back = "What is a <turbo-frame>?"
    expect(basic_note.anki_back).to start_with("What is a &lt;turbo-frame&gt;?")
    expect(basic_note.anki_back).to end_with("/articles/#{article.id}\">Edit</a>")
  end

  it "replaces HTML characters with HTML entities and replaces newline characters with HTML linebreaks" do
    basic_note = build(:basic_note, article:)
    basic_note.back = "hello\nworld\nWhat is a <turbo-frame>?"
    expect(basic_note.anki_back).to start_with("hello<br>world<br>What is a &lt;turbo-frame&gt;?")
    expect(basic_note.anki_back).to end_with("/articles/#{article.id}\">Edit</a>")
  end
end
# rubocop:enable RSpec/MultipleExpectations
