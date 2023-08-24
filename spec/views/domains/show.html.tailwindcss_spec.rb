# frozen_string_literal: true

RSpec.describe "domains/show" do
  let(:user) { create(:user) }
  let(:domain) { create(:domain, user:) }

  before do
    assign(:domain, domain)
    allow(view).to receive(:logged_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    assign(:books, Book.none)
    assign(:child_domains, Domain.none)
    assign(:parent_domain, nil)
  end

  context "when the domain has no books or child domains" do
    it "does not show 'Books' or 'Child domains'" do
      render
      expect(rendered).not_to have_text("Books")
      expect(rendered).not_to have_text("Child domains")
    end
  end

  context "when the domain has books and child domains" do
    before do
      assign(:books, create_list(:book, 4, users: [user]))
      assign(:child_domains, create_list(:domain, 5, user:))
    end

    it "shows 'Books' and 'Child domains'" do
      render
      expect(rendered).to have_text("Books")
      expect(rendered).to have_text("Child domains")
    end
  end

  context "when the domain has a parent domain" do
    before { assign(:parent_domain, create(:domain, user:)) }

    it "shows 'Parent domain:'" do
      render
      expect(rendered).to have_text("Parent domain")
    end
  end
end
