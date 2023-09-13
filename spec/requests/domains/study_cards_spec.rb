# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /domains/:id/study_cards", "#study_cards" do
  subject(:get_domain_study_cards) { get study_domain_cards_path(domain) }

  let(:domain) { create(:domain, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the domain does not belong to the user" do
      get_domain_study_cards
      expect(response).to redirect_to(root_path)
    end

    context "when the domain belongs to the user" do
      let(:domain) { create(:domain, user:) }

      it "returns a success response" do
        get_domain_study_cards
        expect(response).to be_successful
      end

      context "when domain cannot be found because it was deleted" do
        before { domain.destroy }

        it "redirects to the homepage" do
          get_domain_study_cards
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
