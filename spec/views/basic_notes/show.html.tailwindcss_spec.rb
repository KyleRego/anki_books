# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/InstanceVariable
RSpec.describe "basic_notes/show" do
  before do
    @article = create(:article)
    @basic_note = create(:basic_note, article: @article)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(TEST_BASIC_NOTE_BACK)
  end
end
# rubocop:enable RSpec/InstanceVariable
