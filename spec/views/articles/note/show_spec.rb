# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "articles/note/show" do
  subject(:render_article_basic_note) do
    render partial: "articles/note/show"
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:basic_note) { create(:basic_note, article:) }

  before do
    assign(:article, article)
    assign(:note, basic_note)
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
end
