# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "GET /book_groups/:id", "#show" do
  subject(:get_book_groups_show) { get book_group_path(book_group) }

  let(:book_group) { create(:book_group, users: [create(:user)]) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:book_group) { create(:book_group, users: [user]) }

    before { create_list(:book, 4, book_groups: [book_group]) }

    it "returns a success response" do
      get_book_groups_show
      expect(response).to be_successful
    end

    it "redirects to the root path and shows a flash message if the book group cannot be found" do
      get "/book_groups/notfound"
      expect(response).to redirect_to root_path
      expect(flash[:alert]).not_to be_nil
    end
  end
end
