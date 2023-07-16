# frozen_string_literal: true

# :nodoc:
class BookGroupsUser < ApplicationRecord
  belongs_to :book_group
  belongs_to :user
end
