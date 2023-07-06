# frozen_string_literal: true

require_relative "../../support/shared_contexts/user_logged_in"
require_relative "../../support/shared_examples/not_logged_in_user_gets_redirected_to_login"

RSpec.describe "GET /random_article", "#random_article" do
  subject(:get_users_random_article) { get user_random_article_path }

  include BasicNotesHelper

  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    before do
      10.times do
        book = create(:book, users: [user])
        create_list(:article, 5, book:)
      end
    end

    it "returns a redirect to an article" do
      get_users_random_article
      expect(response).to have_http_status(:found)
      expect(response.location).to match(%r{articles/.+})
    end
  end
end
