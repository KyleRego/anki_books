# frozen_string_literal: true

require "rails_helper"

RSpec.describe "domains/show" do
  let(:user) { create(:user) }
  let(:domain) { create(:domain, user:) }

  before do
    assign(:domain, domain)
    allow(view).to receive(:logged_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
  end

  context "when the domain has no books, parent domains, or child domains" do
    before do
      assign(:books, Book.none)
      assign(:parent_domains, Domain.none)
      assign(:child_domains, Domain.none)
    end

    it "does not show Books, Parent domains, or Child domains" do
      render
      expect(rendered).not_to have_text("Books")
      expect(rendered).not_to have_text("Parent domains")
      expect(rendered).not_to have_text("Child domains")
    end
  end

  context "when the domain has books, parent domains, and child domains" do
    before do
      assign(:books, create_list(:book, 4, users: [user]))
      assign(:parent_domains, create_list(:domain, 4, user:))
      assign(:child_domains, create_list(:domain, 5, user:))
    end

    it "shows Books, Parent domains, and Child domains" do
      render
      expect(rendered).to have_text("Books")
      expect(rendered).to have_text("Parent domains")
      expect(rendered).to have_text("Child domains")
    end
  end
end
