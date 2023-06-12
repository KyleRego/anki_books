# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"

require "rails_helper"

RSpec.describe "Users" do
  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "GET /users/:id/books" do
    it "redirects to the root page if user is not logged in" do
      get books_path
      expect(response).to redirect_to(root_path)
    end

    context "when user is logged in" do
      include_context "when the user is logged in"

      it "returns a success response" do
        get books_path
        expect(response).to be_successful
      end
    end
  end
end
