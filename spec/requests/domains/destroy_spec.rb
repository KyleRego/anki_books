# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

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

      it "deletes the domain and redirects to the user's books" do
        expect { delete_domains_destroy }.to change(Domain, :count).by(-1)
        expect(response).to redirect_to books_path
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
