# frozen_string_literal: true

RSpec.describe "GET /domains/:id/manage", "#manage" do
  subject(:get_domains_manage) { get manage_domain_path(domain) }

  let(:domain) { create(:domain, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the domain does not belong to the user" do
      get_domains_manage
      expect(response).to redirect_to(root_path)
    end

    context "when the domain belongs to the user" do
      let(:domain) { create(:domain, user:) }

      it "returns a success response" do
        get_domains_manage
        expect(response).to be_successful
      end

      context "when the domain has books and child domains" do
        before do
          create_list(:book, 4, users: [user]).each { |book| domain.books << book }
          create_list(:domain, 3, user:).each { |child_domain| domain.domains << child_domain }
        end

        it "returns a success response" do
          get_domains_manage
          expect(response).to be_successful
        end
      end
    end

    it "redirects to the homepage if the domain is not found" do
      get "/domains/asdf/manage"
      expect(response).to redirect_to(root_path)
    end
  end
end
