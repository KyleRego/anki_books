# frozen_string_literal: true

##
# A book is a container for articles
class Book < ApplicationRecord
  include TitleSluggable

  has_many :articles, dependent: :destroy
  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  validates :title, presence: true
end