# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Books" do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe "POST /books" do
    context "when user is logged in" do
      include_context "when the user is logged in"

      it "creates a new book" do
        expect { post books_path, params: { book: { title: "the title" } } }.to change(Book, :count).by 1
        expect(user.books.last.title).to eq "the title"
      end

      it "does not create a new book and shows a flash alert if the title was blank" do
        expect { post books_path, params: { book: { title: "" } } }.not_to change(Book, :count)
        expect(flash[:alert]).to eq("A book must have a title.")
      end
    end

    context "when not logged in" do
      it "does not create a new book" do
        expect { post books_path, params: { book: { title: "the title" } } }.not_to change(Book, :count)
      end
    end
  end
end
