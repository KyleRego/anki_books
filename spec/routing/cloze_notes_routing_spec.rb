# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNotesController do
  let(:article_id) { "1e8e5d81-09b4-4777-bbea-f024997d6b35" }
  let(:cloze_note_id) { "9" }

  describe "routing" do
    it "routes to #new" do
      path = "/articles/#{article_id}/cloze_notes/new"
      expect(get: path).to route_to("cloze_notes#new", article_id:)
    end

    it "routes to #create" do
      path = "/articles/#{article_id}/cloze_notes"
      expect(post: path).to route_to("cloze_notes#create", article_id:)
    end

    it "routes to #edit" do
      path = "/articles/#{article_id}/cloze_notes/#{cloze_note_id}/edit"
      expect(get: path).to route_to("cloze_notes#edit", article_id:, id: cloze_note_id)
    end

    it "routes to #update" do
      path = "/articles/#{article_id}/cloze_notes/#{cloze_note_id}"
      expect(patch: path).to route_to("cloze_notes#update", article_id:, id: cloze_note_id)
    end
  end
end
