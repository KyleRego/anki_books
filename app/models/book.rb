# frozen_string_literal: true

##
# A book is a container for a group of articles
class Book < ApplicationRecord
  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  has_many :book_groups_books, dependent: :destroy
  has_many :book_groups, through: :book_groups_books

  has_many :articles, dependent: :destroy
  has_many :ordered_articles, -> { order(:ordinal_position) }, class_name: "Article", inverse_of: :book, dependent: :destroy

  validates :title, presence: true

  # rubocop:disable Rails/Delegate
  def articles_count
    articles.count
  end
  # rubocop:enable Rails/Delegate

  def ordered_notes
    BasicNote.joins(article: :book)
             .where(articles: { book_id: id })
             .order("articles.ordinal_position, basic_notes.ordinal_position")
  end
end
