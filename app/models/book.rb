# frozen_string_literal: true

# :nodoc:
class Book < ApplicationRecord
  has_many :articles, -> { order(:ordinal_position) }, inverse_of: :book, dependent: :destroy
  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  validates :title, presence: true

  # TODO: Look into why this cop wants to auto-correct this
  # rubocop:disable Rails/Delegate
  def articles_count
    articles.count
  end
  # rubocop:enable Rails/Delegate
end
