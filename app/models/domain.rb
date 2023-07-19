# frozen_string_literal: true

##
# A domain is a container for a group of related books
class Domain < ApplicationRecord
  belongs_to :user, optional: false
  has_many :books_domains, dependent: :destroy
  has_many :books, -> { order(:title) }, through: :books_domains

  validates :title, presence: true
end
