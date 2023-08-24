# frozen_string_literal: true

RSpec.describe "GET /downloads", "#downloads" do
  subject(:get_users_downloads) { get(downloads_path) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a success response" do
      get_users_downloads
      expect(response).to be_successful
    end
  end
end
