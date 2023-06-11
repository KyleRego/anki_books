# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions" do
  describe "GET /login" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
