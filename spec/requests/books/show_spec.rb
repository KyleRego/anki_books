# frozen_string_literal: true

RSpec.describe "Books" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:book_unrelated_to_user) { create(:book) }

  describe "GET /books/:id" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "returns a success response" do
        get book_path(book)
        expect(response).to be_successful
      end

      it "redirects to the homepage if the book is not found" do
        get "/books/asdf"
        expect(response).to redirect_to(root_path)
      end

      it "redirects to the homepage if the book does not belong to the user" do
        get book_path(book_unrelated_to_user)
        expect(response).to redirect_to(root_path)
      end
    end

    it "redirects to homepage if user is not logged in" do
      get book_path(book)
      expect(response).to redirect_to root_path
    end
  end
end
