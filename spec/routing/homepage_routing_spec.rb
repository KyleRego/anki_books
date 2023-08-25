# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe HomepageController do
  it "routes to #homepage" do
    expect(get: "/").to route_to("homepage#show")
  end

  it "routes to #study_cards" do
    expect(get: "/study_cards").to route_to("homepage#study_cards")
  end
end
