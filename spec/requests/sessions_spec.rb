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

      before { post "/login", params: { session: { email: user.email, password: TEST_USER_PASSWORD } } }

      it "logs the user in successfully" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "shows the successful login notice" do
        expect(flash[:notice]).to eq("Logged in successfully.")
      end

      it "redirects to the root path" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "with user credentials that don't exist" do
      before { post "/login", params: { session: { email: "stannis@themannis.com", password: "wrongpassword123" } } }

      it "doesn't log the user in" do
        expect(session[:user_id]).to be_nil
      end

      it "shows the unsuccessful login alert" do
        expect(flash[:alert]).to eq "Invalid email or password."
      end

      it "redirects to the login path" do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "DELETE /logout" do
    context "with a user logged in" do
      let(:user) { create(:user) }

      before do
        # Sending GET to the root path initializes the session.
        get root_path
        session[:user_id] = user.id
        delete "/logout"
      end

      it "logs out the user" do
        expect(session[:user_id]).to be_nil
      end

      it "shows the successful logout notice" do
        expect(flash[:notice]).to eq("Logged out successfully.")
      end

      it "redirects to the root path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
