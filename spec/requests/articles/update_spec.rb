# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /articles/:id for a non-system article", "#update" do
  subject(:patch_articles_update) do
    params = { article: { title:, content:, reading:, writing:, complete: } }

    patch(article_path(article, format: :turbo_stream),
          params:,
          headers: { "Turbo-Frame": "article_#{article.id}" })
  end

  let(:title) { "new title 1 2 3" }
  let(:content) { "some content" }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }
  let(:reading) { true }
  let(:writing) { false }
  let(:complete) { false }

  include_examples "user is not logged in and needs to be"

  context "when the user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the article does not belong to one of the user's books" do
      patch_articles_update
      expect(response).to redirect_to root_path
    end

    context "when the article belongs to one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      it "updates the article and returns a Turbo Stream response" do
        patch_articles_update
        expect(article.reload.title).to eq(title)
        expect(response.media_type).to eq Mime[:turbo_stream]
      end

      context "when reading, writing, complete are in the params" do
        let(:reading) { false }
        let(:writing) { true }
        let(:complete) { false }

        it "updates the article with those attributes updated to the param values" do
          patch_articles_update
          expect(article.reload.reading).to be reading
          expect(article.reload.writing).to be writing
          expect(article.reload.complete).to be complete
          expect(response.media_type).to eq Mime[:turbo_stream]
        end
      end

      context "when it is the system article" do
        let(:article) { create(:article, book:, system: true) }

        it "updates the article and returns a Turbo Stream response" do
          patch_articles_update
          expect(article.reload.title).to eq(title)
          expect(response.media_type).to eq Mime[:turbo_stream]
        end
      end

      context "when the parameters are invalid" do
        let(:title) { "" }

        it "does not update the article" do
          patch_articles_update
          expect(article.reload.title).not_to eq("")
          expect(response.media_type).to eq Mime[:turbo_stream]
          expect(response.body).to include("Title can&#39;t be blank")
        end
      end
    end
  end
end
