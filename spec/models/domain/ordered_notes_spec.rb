# frozen_string_literal: true

RSpec.describe Domain, "#ordered_notes" do
  subject(:ordered_notes) { domain.ordered_notes }

  let(:user) { create(:user) }
  let(:domain) { create(:domain, user:) }

  context "when the domain has no books" do
    # This setup is to ensure unrelated data is not returned
    before do
      book = create(:book, users: [create(:user)])
      article = create(:article, book:)
      create_list(:basic_note, 4, article:)
      book = create(:book, users: [])
      article = create(:article, book:)
      create_list(:basic_note, 4, article:)
    end

    it "returns an empty collection" do
      expect(ordered_notes).to be_empty
    end
  end

  context "when the domain has one book with one article with 10 basic notes" do
    before do
      book = create(:book, users: [user])
      article = create(:article, book:)
      create_list(:basic_note, 10, article:)
      domain.books << book
    end

    it "returns the 10 basic notes" do
      expect(ordered_notes.count).to eq 10
      expect(ordered_notes.first.ordinal_position).to eq 0
      expect(ordered_notes.last.ordinal_position).to eq 9
    end
  end

  context "when the domain has 2 books, 4 articles, 20 basic notes" do
    let(:first_book) { create(:book, title: "A", users: [user]) }

    let(:first_book_first_article) { create(:article, book: first_book) }
    let(:first_book_second_article) { create(:article, book: second_book) }

    let(:second_book) { create(:book, title: "Z", users: [user]) }

    let(:second_book_first_article) { create(:article, book: second_book) }
    let(:second_book_second_article) { create(:article, book: second_book) }

    before do
      domain.books = [first_book, second_book]
      create_list(:basic_note, 5, article: first_book_first_article)
      create_list(:basic_note, 5, article: first_book_second_article)
      create_list(:basic_note, 5, article: second_book_first_article)
      create_list(:basic_note, 5, article: second_book_second_article)
    end

    it "returns the 20 basic notes in the correct order" do
      expect(ordered_notes.count).to eq 20
      expect(ordered_notes.first.article.id).to eq first_book_first_article.id
      expect(ordered_notes[6].article.id).to eq first_book_second_article.id
      expect(ordered_notes[11].article.id).to eq second_book_first_article.id
      expect(ordered_notes[16].article.id).to eq second_book_second_article.id
    end
  end

  context "when the domain has a child book that is also a child book of a child domain" do
    let(:book) { create(:book, users: [user]) }
    let(:child_domain) { create(:domain, user:) }
    let(:article) { create(:article, book:) }

    before do
      create_list(:basic_note, 10, article:)
      domain.books << book
      domain.child_domains << child_domain
      child_domain.books << book
    end

    it "returns the 10 basic notes with no duplicates" do
      expect(ordered_notes.count).to eq 10
    end
  end

  context "when the domain has a very nested child domain with basic notes" do
    before do
      child_domain = create(:domain, user:)
      domain.child_domains << child_domain
      second_nested_domain = create(:domain, user:)
      child_domain.child_domains << second_nested_domain
      third_nested_domain = create(:domain, user:)
      second_nested_domain.child_domains << third_nested_domain
      book = create(:book, users: [user])
      second_nested_domain.books << book
      article = create(:article, book:)
      create_list(:basic_note, 11, article:)
    end

    it "returns the nested domain's book basic notes" do
      expect(ordered_notes.count).to eq 11
    end
  end
end
