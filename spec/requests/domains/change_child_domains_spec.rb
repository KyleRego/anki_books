# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "PATCH /domains/:id/change_child_domains", "#change_child_domains" do
  subject(:patch_domains_change_child_domains) do
    patch change_child_domains_path(domain), params: { child_domain_ids: }
  end

  let(:domain) { create(:domain, user: create(:user)) }
  let(:child_domain_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:domain) { create(:domain, user:) }

    it "redirects to the domain manage page" do
      patch_domains_change_child_domains
      expect(response).to redirect_to(manage_domain_path(domain))
    end

    context "when child_domain_ids param is given" do
      before { create_list(:domain, 10, user:) }

      let(:child_domain_ids) { user.domains.where.not(id: domain.id).first(4).pluck(:id) }

      it "updates the child domains of the domain" do
        patch_domains_change_child_domains
        expect(domain.child_domains.reload.pluck(:id).sort).to eq user.domains.where(id: child_domain_ids).reload.pluck(:id).sort
      end
    end
  end
end
