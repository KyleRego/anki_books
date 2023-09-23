# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "DELETE /domains/:id", "#destroy" do
  subject(:delete_domains_destroy) do
    delete domain_path(domain)
  end

  let!(:domain) { create(:domain, user: create(:user)) }

  include_examples "user is not logged in and needs to be"

  it "does not delete the domain when the user is not logged in and needs to be" do
    expect { delete_domains_destroy }.not_to change(Domain, :count)
    expect(response).to redirect_to login_path
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    context "when the domain does not belong to the user" do
      it "does not delete the domain and redirects to the homepage" do
        expect { delete_domains_destroy }.not_to change(Domain, :count)
        expect(response).to redirect_to root_path
      end
    end

    context "when the domain does belong to the user" do
      let!(:domain) { create(:domain, user:) }

      it "deletes the domain and redirects to the user's domains" do
        expect { delete_domains_destroy }.to change(Domain, :count).by(-1)
        expect(response).to redirect_to domains_path
      end

      context "when the domain has a child domain" do
        let!(:child_domain) { create(:domain, parent_domain: domain, user:) }

        it "deletes the domain and nullifies the parent_domain_id of the child domain" do
          expect { delete_domains_destroy }.to change(Domain, :count).by(-1)
          expect(child_domain.reload.parent_domain).to be_nil
        end
      end

      context "when the domain belongs to the user and has some associated books" do
        let!(:books) do
          books = create_list(:book, 4, users: [user])
          domain.books = books
          books
        end

        it "deletes the domain but does not delete the books" do
          expect { delete_domains_destroy }.to change(Domain, :count).by(-1)
          expect(user.books.pluck(:id).sort).to eq books.pluck(:id).sort
        end
      end
    end
  end
end
