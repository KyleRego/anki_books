# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_is_unauthorized"

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
