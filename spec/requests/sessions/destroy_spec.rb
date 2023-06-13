# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

require "rails_helper"

RSpec.describe "Sessions" do
  describe "GET /logout" do
    context "when user is logged in" do
      include_context "when the user is logged in"

      it "destroys the session" do
        delete logout_path
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
