# frozen_string_literal: true

##
# A book group is a container for a group of related books
class BookGroup < ApplicationRecord
  has_many :book_groups_users, dependent: :destroy
  has_many :users, through: :book_groups_users
  has_many :book_groups_books, dependent: :destroy
  has_many :books, -> { order(:title) }, through: :book_groups_books

  validates :title, presence: true
end
