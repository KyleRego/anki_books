# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "GET /root_domains", "#root_domains" do
  subject(:get_root_domains) { get root_domains_path }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    before { create_list(:domain, 4, user:) }

    it "returns a success response" do
      get_root_domains
      expect(response).to be_successful
    end
  end
end
