# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

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
