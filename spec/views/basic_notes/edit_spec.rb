# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "basic_notes/edit" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  before do
    assign(:article, article)
    assign(:basic_note, basic_note)
  end

  it "renders the edit basic_note form" do
    render

    assert_select "form[action=?][method=?]", article_basic_note_path(article, basic_note), "post" do
      assert_select "textarea[name=?]", "basic_note[front]"

      assert_select "textarea[name=?]", "basic_note[back]"
    end
  end
end
