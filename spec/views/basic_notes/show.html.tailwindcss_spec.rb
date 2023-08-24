# frozen_string_literal: true

RSpec.describe "basic_notes/show" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:basic_note) { create(:basic_note, article:) }

  before do
    assign(:article, article)
    assign(:basic_note, basic_note)
  end

  context "when user is logged in" do
    before do
      allow(view).to receive(:logged_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
    end

    it "renders the basic note as draggable" do
      render
      expect(rendered).to have_css(".draggable-div-of-note[draggable='true']")
    end
  end

  context "when user is not logged in and needs to be" do
    it "renders the basic note without the draggable element" do
      render
      expect(rendered).to match(TEST_BASIC_NOTE_FRONT)
      expect(rendered).to match(TEST_BASIC_NOTE_BACK)
      expect(rendered).not_to have_css(".draggable-div-of-note")
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
