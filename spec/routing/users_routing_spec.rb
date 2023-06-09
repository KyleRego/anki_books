# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController do
  let(:user_id) { "6" }

  describe "routing" do
    it "routes to #download_anki_deck" do
      expect(get: "/download_anki_deck").to route_to("users#download_anki_deck")
    end

    it "routes to #random_article" do
      expect(get: "random_article").to route_to("users#random_article")
    end
  end
end
