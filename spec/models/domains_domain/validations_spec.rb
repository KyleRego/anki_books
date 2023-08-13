# frozen_string_literal: true

require "rails_helper"

RSpec.describe DomainsDomain, "#valid?" do
  it "is invalid when parent_domain_id is equal to child_domain_id" do
    domains_domain = described_class.new(parent_domain_id: "a", child_domain_id: "a")
    expect(domains_domain).not_to be_valid
  end
end
