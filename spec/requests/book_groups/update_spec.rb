# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "PATCH /book_groups/:id", "#update" do
  subject(:patch_book_groups_update) { patch book_group_path(book_group), params: { book_group: { title: } } }

  let(:book_group) { create(:book_group, users: [create(:user)]) }
  let(:title) { "New book group title" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:book_group) { create(:book_group, users: [user]) }

    it "updates the book group" do
      expect { patch_book_groups_update }.to change(BookGroup, :count).by 1
      expect(user.book_groups.last.title).to eq title
    end

    context "when the title parameter is blank" do
      let(:title) { "" }

      it "does not update the book group and shows a flash alert" do
        patch_book_groups_update
        expect(book_group.title).not_to eq ""
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
