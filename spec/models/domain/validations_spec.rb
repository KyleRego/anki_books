# frozen_string_literal: true

RSpec.describe Domain, "#valid?" do
  let(:user) { create(:user) }

  it "is valid with a title" do
    domain = build(:domain, title: "Example Title", user:)
    expect(domain).to be_valid
  end

  it "is invalid with an empty string title" do
    domain = build(:domain, title: "", user:)
    expect(domain).to be_invalid
  end

  it "is invalid without a title" do
    domain = build(:domain, title: nil, user:)
    expect(domain).to be_invalid
  end

  it "is invalid without a user" do
    domain = build(:domain, title: "Example Title")
    expect(domain).to be_invalid
  end
end
