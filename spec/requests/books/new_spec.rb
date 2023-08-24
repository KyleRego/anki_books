# frozen_string_literal: true

RSpec.describe "GET /books/new", "#new" do
  subject(:get_books_new) { get(new_book_path) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a success response" do
      get_books_new
      expect(response).to be_successful
    end
  end
end
