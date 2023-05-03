# frozen_string_literal: true

HOMEPAGE_BASIC_NOTE_FRONT = "front of homepage basic note"
HOMEPAGE_BASIC_NOTE_BACK = "back of homepage basic note"

When "the homepage has a basic note" do
  create(:basic_note, article: @system_article, front: HOMEPAGE_BASIC_NOTE_FRONT, back: HOMEPAGE_BASIC_NOTE_BACK)
end
