# frozen_string_literal: true

require "rails_helper"

RSpec.describe "basic_notes/new" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  before do
    assign(:article, article)
    assign(:basic_note, basic_note)
  end

  it "renders new basic_note form" do
    render

    assert_select "form[action=?][method=?]", article_basic_notes_path(article), "post" do
      assert_select "textarea[name=?]", "basic_note[front]"

      assert_select "textarea[name=?]", "basic_note[back]"
    end
  end
end
