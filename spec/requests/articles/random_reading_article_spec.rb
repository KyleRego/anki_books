# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /random_reading_article", "#random_article" do
  subject(:get_users_random_reading_article) { get random_article_path }

  let(:user) { create(:user) }

  context "when user is unauthenticated" do
    context "when there is a public book with an article" do
      before do
        book = create(:book, allow_anonymous: true)
        create(:article, book:)
      end

      it "is successful" do
        get_users_random_reading_article
        expect(response).to have_http_status(:found)
      end
    end
  end

  context "when user is logged in" do
    include_context "when the user is logged in"

    context "when user has no articles" do
      it "redirects to books page with a flash message" do
        get_users_random_reading_article
        expect(response).to redirect_to books_path
        expect(flash[:notice]).not_to be_empty
      end
    end

    context "when user has only reading: false articles" do
      before do
        10.times do
          book = create(:book, users: [user])
          create_list(:article, 5, book:, reading: false, complete: false)
        end
      end

      it "redirects to books page with a flash message" do
        get_users_random_reading_article
        expect(response).to redirect_to books_path
        expect(flash[:notice]).not_to be_empty
      end
    end

    context "when user has reading articles" do
      before do
        10.times do
          book = create(:book, users: [user])
          create_list(:article, 5, book:, reading: true, complete: false)
        end
      end

      it "returns a redirect to an article" do
        get_users_random_reading_article
        expect(response).to have_http_status(:found)
        expect(response.location).to match(%r{articles/.+})
      end
    end
  end
end
