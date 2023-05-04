# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/DescribeMethod
RSpec.describe Article, "validations" do
  it "is valid with a title" do
    article = build(:article, title: "Example Title")
    expect(article).to be_valid
  end

  it "is invalid with an empty string title" do
    article = build(:article, title: "")
    expect(article).to be_invalid
  end

  it "is invalid without a title" do
    article = build(:article, title: nil)
    expect(article).to be_invalid
  end
end
# rubocop:enable RSpec/DescribeMethod
