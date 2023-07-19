# frozen_string_literal: true

# :nodoc:
class BooksDomain < ApplicationRecord
  belongs_to :domain
  belongs_to :book
end
