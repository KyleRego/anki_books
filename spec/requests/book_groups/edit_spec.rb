# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "GET /book_groups/:id/edit" do
  subject(:get_book_groups_edit) { get edit_book_group_path(book_group) }

  let(:book_group) { create(:book_group, users: [create(:user)]) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:book_group) { create(:book_group, users: [user]) }

    it "returns a success response" do
      get_book_groups_edit
      expect(response).to be_successful
    end
  end
end
