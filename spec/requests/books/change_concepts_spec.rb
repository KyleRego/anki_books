# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /books/:id/change_concepts", "#change_concepts" do
  subject(:patch_books_change_concepts) { patch(change_book_concepts_path(book), params:) }

  let(:params) { { concepts_ids: } }
  let(:concepts_ids) { [] }
  let(:book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the book does not belong to the user" do
      patch_books_change_concepts
      expect(response).to redirect_to(root_path)
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "redirects back to the manage book page" do
        patch_books_change_concepts
        expect(response).to redirect_to(manage_book_path(book))
      end

      context "when book cannot be found because it was deleted" do
        before { book.destroy }

        it "redirects to the homepage" do
          patch_books_change_concepts
          expect(response).to redirect_to(root_path)
        end
      end

      context "when concepts_ids param is given and are ids of the user's concepts" do
        let(:concepts_ids) { user.concepts.first(3).pluck(:id) }

        before { create_list(:concept, 5, user:) }

        it "changes the book's concepts to be the selected ones" do
          patch_books_change_concepts
          expect(book.concepts.count).to eq 3
        end
      end

      context "when concept_ids param includes ids of concepts not belonging to the user" do
        let(:concepts_ids) { Concept.all.pluck(:id) }

        before do
          create_list(:concept, 4, user:)
          create_list(:concept, 4, user: create(:user))
        end

        it "changes the book's concepts to only the user's concepts" do
          patch_books_change_concepts
          expect(book.concepts.count).to eq 4
        end
      end

      context "when book already had concepts that were not selected" do
        let(:concepts_ids) { Concept.take(2).pluck(:id) }

        before { create_list(:concept, 4, user:, books: [book]) }

        it "changes the book's concepts to be only the selected one" do
          patch_books_change_concepts
          expect(book.concepts.count).to eq 2
        end
      end
    end
  end
end
