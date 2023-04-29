# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/InstanceVariable
RSpec.describe "basic_notes/edit" do
  before do
    @article = create(:article)
    @basic_note = create(:basic_note, article: @article)
  end

  it "renders the edit basic_note form" do
    render

    assert_select "form[action=?][method=?]", edit_article_basic_note_path(@article, @basic_note), "post" do
      assert_select "textarea[name=?]", "basic_note[front]"

      assert_select "textarea[name=?]", "basic_note[back]"
    end
  end
end
# rubocop:enable RSpec/InstanceVariable
