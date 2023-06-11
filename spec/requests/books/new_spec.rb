# frozen_string_literal: true

RSpec.describe "Books" do
  let(:user) { create(:user) }

  describe "GET /books/new" do
    context "when user is logged in" do
      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "returns a success response" do
        get(new_book_path)
        expect(response).to be_successful
      end
    end

    it "redirects to homepage if user is not logged in" do
      get(new_book_path)
      expect(response).to redirect_to root_path
    end
  end
end
