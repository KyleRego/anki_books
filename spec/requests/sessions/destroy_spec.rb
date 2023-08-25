# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "DELETE /logout", "#destroy" do
  subject(:delete_sessions_destroy) do
    delete "/logout"
  end

  it "returns a 422 response if the user is not logged in and needs to be" do
    delete_sessions_destroy
    expect(response).to have_http_status :unprocessable_entity
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "destroys the session" do
      delete_sessions_destroy
      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to eq("Logged out successfully.")
      expect(response).to redirect_to(root_path)
    end
  end
end
