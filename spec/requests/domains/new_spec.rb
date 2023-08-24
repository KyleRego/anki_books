# frozen_string_literal: true

RSpec.describe "GET /domains/new", "#new" do
  subject(:get_domains_new) { get new_domain_path }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "returns a success response" do
      get_domains_new
      expect(response).to be_successful
    end
  end
end
