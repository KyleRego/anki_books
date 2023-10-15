# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#random_writing_article" do
  subject(:random_writing_article) { user.random_writing_article }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }

  context "when user has one article that is writing: true and complete: false" do
    let!(:article) { create(:article, book:, writing: true, complete: false) }

    it "returns the writing article" do
      expect(random_writing_article).to eq article
    end
  end

  context "when user has one article that is writing: true and complete: true" do
    before { create(:article, book:, writing: true, complete: true) }

    it "returns nil" do
      expect(random_writing_article).to be_nil
    end
  end

  context "when user has one article that is writing: false" do
    before { create(:article, book:, writing: false, complete: false) }

    it "returns nil" do
      expect(random_writing_article).to be_nil
    end
  end

  context "when user has multiple books and many articles" do
    before do
      create_list(:book, 5, users: [user])
      user.books.each do |book|
        create_list(:article, 10, book:, writing: true, complete: false)
      end
    end

    it "returns different articles when called multiple times" do
      returned_articles = []
      5.times { returned_articles << user.random_writing_article }
      expect(returned_articles.count).to be >= 4
    end
  end
end
