# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "PATCH /books/:id/change_book_groups", "#change_book_groups" do
  subject(:post_books_change_book_groups) { patch(change_book_groups_path(book), params:) }

  let(:params) { { book_groups_ids: } }
  let(:book_groups_ids) { [] }
  let(:book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the book does not belong to the user" do
      post_books_change_book_groups
      expect(response).to redirect_to(root_path)
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "redirects back to the manage book page" do
        post_books_change_book_groups
        expect(response).to redirect_to(manage_book_path(book))
      end

      context "when book_groups_ids param is given and are ids of the user's book groups" do
        let(:book_groups_ids) { user.book_groups.first(3).pluck(:id) }

        before { create_list(:book_group, 5, users: [user]) }

        it "changes the book's book groups to be the selected ones" do
          post_books_change_book_groups
          expect(book.book_groups.count).to eq 3
        end
      end

      context "when book_group_ids param includes ids of book groups not belonging to the user" do
        let(:book_groups_ids) { BookGroup.all.pluck(:id) }

        before do
          create_list(:book_group, 4, users: [user])
          create_list(:book_group, 4)
        end

        it "changes the book's book groups to only the user's book groups" do
          post_books_change_book_groups
          expect(book.book_groups.count).to eq 4
        end
      end

      context "when book already had book groups that were not selected" do
        let(:book_groups_ids) { BookGroup.take(2).pluck(:id) }

        before { create_list(:book_group, 4, users: [user], books: [book]) }

        it "changes the book's book groups to be only the selected one" do
          post_books_change_book_groups
          expect(book.book_groups.count).to eq 2
        end
      end
    end

    it "redirects to the homepage if the book is not found" do
      get "/books/asdf/edit"
      expect(response).to redirect_to(root_path)
    end
  end
end
