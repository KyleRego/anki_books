# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "PATCH /domains/:id", "#update" do
  subject(:patch_domains_update) { patch domain_path(domain), params: { domain: { title: } } }

  let(:domain) { create(:domain, user: create(:user)) }
  let(:title) { "New domain title" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:domain) { create(:domain, user:) }

    it "updates the domain" do
      expect { patch_domains_update }.to change(Domain, :count).by 1
      expect(user.domains.last.title).to eq title
    end

    context "when the title parameter is blank" do
      let(:title) { "" }

      it "does not update the domain and shows a flash alert" do
        patch_domains_update
        expect(domain.title).not_to eq ""
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
