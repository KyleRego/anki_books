# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "articles/basic_note/show" do
  subject(:render_article_basic_note) do
    render partial: "articles/basic_note/show"
  end

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
      render_article_basic_note
      expect(rendered).to have_css("div.draggable-div-of-note[draggable='true']")
    end
  end

  context "when user is not logged in" do
    it "renders the basic note without the draggable div element" do
      render_article_basic_note
      expect(rendered).to match(TEST_BASIC_NOTE_FRONT)
      expect(rendered).to match(TEST_BASIC_NOTE_BACK)
      expect(rendered).not_to have_css("div.draggable-div-of-note")
    end
  end
end
