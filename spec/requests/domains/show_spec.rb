# frozen_string_literal: true

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

    context "when the user has books" do
      before { create_list(:book, 6, users: [user]) }

      it "returns a success response" do
        get_domains_show
        expect(response).to be_successful
      end
    end
  end
end
