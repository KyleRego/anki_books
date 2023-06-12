# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

require "rails_helper"

RSpec.describe "Books" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  let(:book_unrelated_to_user) { create(:book) }

  describe "GET /books/:id/manage" do
    it "redirects to the root page if user is not logged in" do
      get manage_book_path(book)
      expect(response).to redirect_to(root_path)
    end

    context "when user is logged in" do
      include_context "when the user is logged in"

      it "returns a success response" do
        get manage_book_path(book)
        expect(response).to be_successful
      end

      it "redirects to the homepage if the book is not found" do
        get "/books/asdf/manage"
        expect(response).to redirect_to(root_path)
      end

      it "redirects to the homepage if the book does not belong to the user" do
        get book_path(book_unrelated_to_user)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
