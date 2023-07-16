# frozen_string_literal: true

# :nodoc:
class BooksUser < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
