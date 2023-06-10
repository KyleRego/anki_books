# frozen_string_literal: true

RSpec.shared_context "when the user has two books, three articles, 5 basic notes per article" do
  let(:user) do
    user = create(:user)

    book = create(:book, users: [user])
    article = create(:article, book:)
    create_list(:basic_note, 5, article:)
    second_article = create(:article, book:)
    create_list(:basic_note, 5, article: second_article)

    second_book = create(:book, users: [user])
    third_article = create(:article, book: second_book)
    create_list(:basic_note, 5, article: third_article)

    user
  end
end
