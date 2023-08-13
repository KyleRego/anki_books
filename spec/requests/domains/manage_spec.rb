# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

require "rails_helper"

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

      context "when the domain has books, parent domains, child domains" do
        before do
          create_list(:book, 4, users: [user]).each { |book| domain.books << book }
          create_list(:domain, 4, user:).each { |parent_domain| domain.parent_domains << parent_domain }
          create_list(:domain, 3, user:).each { |child_domain| domain.child_domains << child_domain }
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
