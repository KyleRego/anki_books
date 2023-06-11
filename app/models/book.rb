# frozen_string_literal: true

# :nodoc:
class Book < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  validates :title, presence: true
end
