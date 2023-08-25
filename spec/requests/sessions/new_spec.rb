# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /login", "#new" do
  subject(:get_sessions_new) { get "/login" }

  it "returns a 200 response" do
    get_sessions_new
    expect(response).to have_http_status(:success)
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage" do
      get_sessions_new
      expect(session[:user_id]).not_to be_nil
      expect(flash[:notice]).to eq("You are logged in already.")
      expect(response).to redirect_to(root_path)
    end
  end
end
