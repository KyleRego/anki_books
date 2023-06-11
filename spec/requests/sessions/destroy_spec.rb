# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions" do
  describe "GET /logout" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      before do
        post login_path, params: { session: { email: user.email, password: TEST_USER_PASSWORD } }
      end

      it "destroys the session" do
        delete logout_path
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
