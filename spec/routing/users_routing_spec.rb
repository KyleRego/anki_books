# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController do
  let(:user_id) { "6" }

  describe "routing" do
    it "routes to #books" do
      expect(get: "/users/#{user_id}/books").to route_to("users#books", id: user_id)
    end

    it "routes to #download_anki_deck" do
      expect(get: "/users/#{user_id}/download_anki_deck").to route_to("users#download_anki_deck", id: user_id)
    end
  end
end
