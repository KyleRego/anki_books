# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

require "rails_helper"

RSpec.describe "DELETE /logout", "#destroy" do
  subject(:delete_sessions_destroy) do
    delete "/logout"
  end

  it "returns a 422 response if the user is not logged in" do
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
