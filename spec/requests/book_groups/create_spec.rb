# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "POST /book_groups", "#create" do
  subject(:post_book_groups_create) { post book_groups_path, params: { book_group: { title: } } }

  let(:title) { "the title" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "creates a new book group" do
      expect { post_book_groups_create }.to change(BookGroup, :count).by 1
      expect(user.book_groups.last.title).to eq title
    end

    context "when the title parameter is blank" do
      let(:title) { "" }

      it "does not create a new book group and shows a flash alert" do
        expect { post_book_groups_create }.not_to change(BookGroup, :count)
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
