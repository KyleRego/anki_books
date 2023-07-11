# frozen_string_literal: true

# :nodoc:
class Book < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :ordered_articles, -> { order(:ordinal_position) }, class_name: "Article", inverse_of: :book, dependent: :destroy
  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

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
