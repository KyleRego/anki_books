# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /books/:id", "#show" do
  subject(:get_books_show) { get book_path(book) }

  let(:book) { create(:book, public:) }
  let(:public) { false }

  before do
    3.times do
      article = create(:article, book:)
      create_list(:basic_note, 4, article:)
    end
  end

  context "when the book is private" do
    it "redirects to the login page" do
      get_books_show
      expect(response).to redirect_to(root_path)
    end
  end

  context "when the book is public" do
    let(:public) { true }

    it "returns a success response" do
      get_books_show
      expect(response).to be_successful
    end
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the book does not belong to the user" do
      get_books_show
      expect(response).to redirect_to(root_path)
    end

    context "when the book is public" do
      let(:public) { true }

      it "returns a success response" do
        get_books_show
        expect(response).to be_successful
      end
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "returns a success response" do
        get_books_show
        expect(response).to be_successful
      end

      context "when book cannot be found because it was deleted" do
        before { book.destroy }

        it "redirects to the homepage" do
          get_books_show
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
