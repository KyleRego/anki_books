# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "PATCH /domains/:id/change_parent_domains", "#change_parent_domains" do
  subject(:patch_domains_change_parent_domains) do
    patch change_parent_domains_path(domain), params: { parent_domain_ids: }
  end

  let(:domain) { create(:domain, user: create(:user)) }
  let(:parent_domain_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:domain) { create(:domain, user:) }

    it "redirects to the manage domain page" do
      patch_domains_change_parent_domains
      expect(response).to redirect_to(manage_domain_path(domain))
    end

    context "when parent_domain_ids param is given" do
      before { create_list(:domain, 10, user:) }

      let(:parent_domain_ids) { user.domains.where.not(id: domain.id).first(4).pluck(:id) }

      it "updates the parent domains of the domain" do
        patch_domains_change_parent_domains
        expect(domain.parent_domains.reload.pluck(:id).sort).to eq user.domains.where(id: parent_domain_ids).reload.pluck(:id).sort
      end
    end
  end
end
