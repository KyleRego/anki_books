# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions" do
  describe "GET /login" do
    it "returns http success" do
      get "/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /login" do
    context "with user credentials that exist" do
      let(:user) { create(:user) }

      it "returns http success" do
        post "/login", params: { session: { username: user.username, email: user.email } }
        expect(response).to have_http_status(:success)
      end
    end

    context "with user credentials that don't exist" do
      it "redirects"
    end
  end

  describe "DELETE /logout" do
    context "with a user logged in" do
      it "logs out the user"
      it "redirects to the root path"
      it "shows a notice flash message"
    end
  end
end
