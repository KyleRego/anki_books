# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

RSpec.describe "Books" do
  let(:user) { create(:user) }

  describe "GET /books/new" do
    context "when user is logged in" do
      include_context "when the user is logged in"
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
