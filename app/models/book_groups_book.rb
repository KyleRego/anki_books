# frozen_string_literal: true

# :nodoc:
class BookGroupsBook < ApplicationRecord
  belongs_to :book_group
  belongs_to :book
end
