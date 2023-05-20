# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotes" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  describe "GET /books/:id/manage_articles" do
    it "redirects to the root page if user is not logged in" do
      get book_manage_articles_path(book, title: book.title_slug)
      expect(response).to redirect_to(root_path)
    end

    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "returns a success response" do
        get book_manage_articles_path(book, title: book.title_slug)
        expect(response).to be_successful
      end
    end
  end
end
