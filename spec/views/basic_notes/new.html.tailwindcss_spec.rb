# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/InstanceVariable
RSpec.describe "basic_notes/new" do
  before do
    @article = create(:article)
    @basic_note = build(:basic_note, article: @article)
  end

  it "renders new basic_note form" do
    render

    assert_select "form[action=?][method=?]", article_basic_notes_path(@article), "post" do
      assert_select "textarea[name=?]", "basic_note[front]"

      assert_select "textarea[name=?]", "basic_note[back]"
    end
  end
end
# rubocop:enable RSpec/InstanceVariable
