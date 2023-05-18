# frozen_string_literal: true

##
# Join record model that connects books with users.
class BooksUser < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
