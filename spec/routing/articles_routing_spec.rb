# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ArticlesController do
  let(:book_id) { "3" }
  let(:article_id) { "1e8e5d81-09b4-4757-bbea-f024997d6b35" }

  describe "routing" do
    it "routes to #new" do
      expect(get: "/books/#{book_id}/articles/new").to route_to("articles#new", book_id:)
    end

    it "routes to #create" do
      path = "/articles"
      expect(post: path).to route_to("articles#create")
    end

    it "routes to #edit" do
      path = "/articles/#{article_id}/edit"
      expect(get: path).to route_to("articles#edit", id: article_id)
    end

    it "routes to #update" do
      path = "/articles/#{article_id}"
      expect(patch: path).to route_to("articles#update", id: article_id)
    end

    it "routes to #show" do
      path = "/articles/#{article_id}"
      expect(get: path).to route_to("articles#show", id: article_id)
    end

    it "routes to #change_note_ordinal_position" do
      path = "/articles/#{article_id}/change_note_ordinal_position"
      expect(post: path).to route_to("articles#change_note_ordinal_position", id: article_id)
    end

    it "routes to #study_cards" do
      path = "/articles/#{article_id}/study_cards"
      expect(get: path).to route_to("articles#study_cards", id: article_id)
    end

    it "routes to #manage" do
      path = "/articles/#{article_id}/manage"
      expect(get: path).to route_to("articles#manage", id: article_id)
    end

    it "routes to #change_book" do
      path = "/articles/#{article_id}/change_book"
      expect(patch: path).to route_to("articles#change_book", id: article_id)
    end

    it "routes to #transfer_notes" do
      path = "/articles/#{article_id}/transfer_notes"
      expect(patch: path).to route_to("articles#transfer_notes", id: article_id)
    end

    it "routes to #destroy" do
      path = "/articles/#{article_id}"
      expect(delete: path).to route_to("articles#destroy", id: article_id)
    end
  end
end
