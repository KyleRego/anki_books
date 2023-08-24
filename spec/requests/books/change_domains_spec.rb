# frozen_string_literal: true

RSpec.describe "PATCH /books/:id/change_domains", "#change_domains" do
  subject(:patch_books_change_domains) { patch(change_book_domains_path(book), params:) }

  let(:params) { { domains_ids: } }
  let(:domains_ids) { [] }
  let(:book) { create(:book) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    it "redirects to the homepage if the book does not belong to the user" do
      patch_books_change_domains
      expect(response).to redirect_to(root_path)
    end

    context "when the book belongs to the user" do
      let(:book) { create(:book, users: [user]) }

      it "redirects back to the manage book page" do
        patch_books_change_domains
        expect(response).to redirect_to(manage_book_path(book))
      end

      context "when domains_ids param is given and are ids of the user's domains" do
        let(:domains_ids) { user.domains.first(3).pluck(:id) }

        before { create_list(:domain, 5, user:) }

        it "changes the book's domains to be the selected ones" do
          patch_books_change_domains
          expect(book.domains.count).to eq 3
        end
      end

      context "when domain_ids param includes ids of domains not belonging to the user" do
        let(:domains_ids) { Domain.all.pluck(:id) }

        before do
          create_list(:domain, 4, user:)
          create_list(:domain, 4, user: create(:user))
        end

        it "changes the book's domains to only the user's domains" do
          patch_books_change_domains
          expect(book.domains.count).to eq 4
        end
      end

      context "when book already had domains that were not selected" do
        let(:domains_ids) { Domain.take(2).pluck(:id) }

        before { create_list(:domain, 4, user:, books: [book]) }

        it "changes the book's domains to be only the selected one" do
          patch_books_change_domains
          expect(book.domains.count).to eq 2
        end
      end
    end

    it "redirects to the homepage if the book is not found" do
      get "/books/asdf/edit"
      expect(response).to redirect_to(root_path)
    end
  end
end
