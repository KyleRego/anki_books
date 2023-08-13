# frozen_string_literal: true

RSpec.describe User, "#domains_domains" do
  subject(:domains_domains) { user.domains_domains }

  let(:user) { create(:user) }

  it "returns empty when user has no books" do
    expect(domains_domains).to be_empty
  end

  context "when the user has one domain associated with another" do
    let(:parent_domain) { create(:domain, user:) }
    let(:child_domain) { create(:domain, user:) }

    before { parent_domain.child_domains << child_domain }

    it "returns the domain domain" do
      expect(domains_domains.count).to eq 1
      domains_domain = domains_domains.first
      expect(domains_domain.parent_domain_id).to eq parent_domain.id
      expect(domains_domain.child_domain_id).to eq child_domain.id
    end
  end

  context "when the user has many 20 domains_domains" do
    before do
      10.times do
        create(:domain, user:).child_domains << create(:domain, user:)
        create(:domain, user:).parent_domains << create(:domain, user:)
      end
    end

    it "returns all 20 domains_domains" do
      expect(domains_domains.count).to eq 20
    end
  end

  context "when a domain has 5 child domains and 5 parent domains" do
    before do
      middle_domain = create(:domain, user:)
      5.times do
        middle_domain.parent_domains << create(:domain, user:)
        middle_domain.child_domains << create(:domain, user:)
      end
    end

    it "returns the 10 domains_domains" do
      expect(domains_domains.count).to eq 10
    end
  end
end
