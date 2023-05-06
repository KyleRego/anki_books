# frozen_string_literal: true

require "rails_helper"

RSpec.describe "basic_notes/show" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  before do
    assign(:article, article)
    assign(:basic_note, basic_note)
  end

  context "when user is logged in" do
    before { allow(view).to receive(:logged_in?).and_return(true) }

    it "renders the basic note as draggable" do
      render
      expect(rendered).to have_css(".draggable-div-of-note[draggable='true']")
    end
  end

  context "when user is not logged in" do
    # rubocop:disable RSpec/MultipleExpectations
    it "renders the basic note but not as a draggable element" do
      render
      expect(rendered).to match(TEST_BASIC_NOTE_FRONT)
      expect(rendered).to match(TEST_BASIC_NOTE_BACK)
      expect(rendered).to have_css(".draggable-div-of-note[draggable='false']")
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
