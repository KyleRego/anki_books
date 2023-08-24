# frozen_string_literal: true

RSpec.describe "GET /books/:id/articles/new", "#new" do
  subject(:get_articles_new) { get new_book_article_path(book) }

  let(:book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    # TODO: This is probably the correct behavior we want for 404 responses
    it "throws a RecordNotFound exception if the user does not have a book with the given id" do
      expect { get get_articles_new }.to raise_exception ActiveRecord::RecordNotFound
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "returns a 200 response" do
        get_articles_new
        expect(response).to be_successful
      end
    end
  end
end
