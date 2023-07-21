# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "GET /domains/:id", "#show" do
  subject(:get_domains_show) { get domain_path(domain) }

  let(:domain) { create(:domain, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:domain) { create(:domain, user:) }

    before { create_list(:book, 4, domains: [domain]) }

    it "returns a success response" do
      get_domains_show
      expect(response).to be_successful
    end

    it "redirects to the root path and shows a flash message if the domain cannot be found" do
      get "/domains/notfound"
      expect(response).to redirect_to root_path
      expect(flash[:alert]).not_to be_nil
    end
  end
end
