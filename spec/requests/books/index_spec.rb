# frozen_string_literal: true

RSpec.describe "GET /books", "#index" do
  subject(:get_books_index) { get(books_path) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a success response" do
      get_books_index
      expect(response).to be_successful
    end
  end
end
