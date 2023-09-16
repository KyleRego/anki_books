# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#random_article" do
  let(:user) { create(:user) }

  context "when user has 5 books each with 3 articles" do
    before do
      5.times do
        book = create(:book, users: [user])
        create_list(:article, 3, book:)
      end
    end

    it "returns an article" do
      expect(user.random_article).to be_a Article
    end

    it "returns at least 2 different articles when called 3 times", retry: 2 do
      first_random_article = user.random_article
      second_random_article = user.random_article
      third_random_article = user.random_article
      result = [first_random_article, second_random_article, third_random_article].uniq
      expect(result.count).to be > 1
    end
  end

  context "when user has one article and there is also another article" do
    it "returns the user's article" do
      book = create(:book, users: [user])
      article = create(:article, book:)
      create(:article, book: create(:book))
      expect(user.random_article).to eq article
    end
  end
end
