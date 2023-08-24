# frozen_string_literal: true

RSpec.describe BasicNotesController do
  let(:article_id) { "1e8e5d81-09b4-4757-bbea-f024997d6b35" }
  let(:basic_note_id) { "5" }

  describe "routing" do
    it "routes to #new" do
      path = "/articles/#{article_id}/basic_notes/new"
      expect(get: path).to route_to("basic_notes#new", article_id:)
    end

    it "routes to #create" do
      path = "/articles/#{article_id}/basic_notes"
      expect(post: path).to route_to("basic_notes#create", article_id:)
    end

    it "routes to #edit" do
      path = "/articles/#{article_id}/basic_notes/#{basic_note_id}/edit"
      expect(get: path).to route_to("basic_notes#edit", article_id:, id: basic_note_id)
    end

    it "routes to #update" do
      path = "/articles/#{article_id}/basic_notes/#{basic_note_id}"
      expect(patch: path).to route_to("basic_notes#update", article_id:, id: basic_note_id)
    end

    it "routes to #show" do
      path = "/articles/#{article_id}/basic_notes/#{basic_note_id}"
      expect(get: path).to route_to("basic_notes#show", article_id:, id: basic_note_id)
    end
  end
end
