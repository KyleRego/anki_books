# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /root_domains", "#root_domains" do
  subject(:get_root_domains) { get root_domains_path }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    before { create_list(:domain, 4, user:) }

    it "returns a success response" do
      get_root_domains
      expect(response).to be_successful
    end
  end
end
