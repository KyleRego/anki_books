# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_is_unauthorized"

RSpec.describe "POST /books", "#create" do
  subject(:post_books_create) { post books_path, params: { book: { title: } } }

  let(:title) { "the title" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "creates a new book" do
      expect { post_books_create }.to change(Book, :count).by 1
      expect(user.books.last.title).to eq title
    end

    context "when the title parameter is blank" do
      let(:title) { "" }

      it "does not create a new book and shows a flash alert" do
        expect { post_books_create }.not_to change(Book, :count)
        expect(flash[:alert]).to eq("A book must have a title.")
      end
    end
  end
end
