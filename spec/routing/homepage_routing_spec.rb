# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomepageController do
  it "routes to #homepage" do
    expect(get: "/").to route_to("homepage#show")
  end

  it "routes to #study_cards" do
    expect(get: "/study_cards").to route_to("homepage#study_cards")
  end
end