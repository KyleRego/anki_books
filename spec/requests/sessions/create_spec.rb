# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "POST /login", "#create" do
  subject(:post_sessions_create) do
    post login_path, params: { session: { email:, password: } }
  end

  before { post_sessions_create }

  context "with user credentials that exist" do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { TEST_USER_PASSWORD }

    it "logs the user in successfully" do
      expect(session[:user_id]).to eq(user.id)
      expect(flash[:notice]).to eq("Logged in successfully.")
      expect(response).to redirect_to(root_path)
    end
  end

  context "with user credentials that don't exist" do
    let(:email) { "unknown_user@test.com" }
    let(:password) { "password_password" }

    it "doesn't log the user in" do
      expect(session[:user_id]).to be_nil
      expect(flash[:alert]).to eq "Invalid email or password."
      expect(response).to redirect_to(login_path)
    end
  end
end
