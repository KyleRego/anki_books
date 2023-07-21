# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "PATCH /domains/:id/change_books", "#change_books" do
  subject(:patch_domains_change_books) { patch change_domain_books_path(domain), params: { book_ids: } }

  let(:domain) { create(:domain, user: create(:user)) }
  let(:book_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:domain) { create(:domain, user:) }
    let(:book_ids) { create_list(:book, 5, users: [user]).pluck(:id).first(2) }

    it "changes the books associated with the domain according to the params" do
      patch_domains_change_books
      expect(domain.books.pluck(:id).sort).to eq book_ids.sort
    end

    context "when the domain had a different set of books" do
      before { create_list(:book, 5, domains: [domain]) }

      it "changes the books associated with the domain to the new set of books according to the params" do
        patch_domains_change_books
        expect(domain.books.pluck(:id).sort).to eq book_ids.sort
      end
    end

    context "when the domain does not belong to the user" do
      let(:domain) { create(:domain, user: create(:user)) }

      it "redirects to the homepage" do
        patch_domains_change_books
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
