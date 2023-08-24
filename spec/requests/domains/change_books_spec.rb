# frozen_string_literal: true

RSpec.describe "PATCH /domains/:id/change_books", "#change_books" do
  subject(:patch_domains_change_books) { patch change_domain_books_path(domain), params: { book_ids: } }

  let(:domain) { create(:domain, user: create(:user)) }
  let(:book_ids) { nil }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:domain) { create(:domain, user:) }
    let(:book_ids) { create_list(:book, 5, users: [user]).pluck(:id).first(2) }

    it "redirects to the manage domain page" do
      patch_domains_change_books
      expect(response).to redirect_to(manage_domain_path(domain))
    end

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
