# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_redirected_to_root"

RSpec.describe "GET /books/new", "#new" do
  subject(:get_books_new) { get(new_book_path) }

  include_examples "user not logged in gets redirected"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a success response" do
      get_books_new
      expect(response).to be_successful
    end
  end
end
