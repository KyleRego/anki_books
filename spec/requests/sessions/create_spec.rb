# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions" do
  describe "POST /login" do
    context "with user credentials that exist" do
      let(:user) { create(:user) }

      before { post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } } }

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
      before { post login_path, params: { session: { email: "stannis@themannis.com", password: "wrongpassword123" } } }

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
end
