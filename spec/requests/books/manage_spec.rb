# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /books/:id/manage", "#manage" do
  subject(:get_books_manage) { get manage_book_path(book) }

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage when book does not belong to the user" do
      get_books_manage
      expect(response).to redirect_to(root_path)
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "returns a success response" do
        get_books_manage
        expect(response).to be_successful
      end

      context "when user has many domains" do
        before { create_list(:domain, 5, user:) }

        it "returns a success response" do
          get_books_manage
          expect(response).to be_successful
        end
      end

      context "when book is not found (it was deleted)" do
        before { book.destroy }

        it "redirects to the homepage" do
          get_books_manage
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
