# frozen_string_literal: true

RSpec.describe "Books" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }

  describe "GET /books/:id" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "returns a success response" do
        get(book_path(book, book.title_slug))
        expect(response).to be_successful
      end
    end

    it "redirects to homepage if user is not logged in" do
      get(book_path(book, book.title_slug))
      expect(response).to redirect_to root_path
    end
  end
end