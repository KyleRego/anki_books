# frozen_string_literal: true

# :nodoc:
class Article < ApplicationRecord
  belongs_to :book, optional: true
  has_rich_text :content
  has_many :basic_notes, dependent: :destroy

  validates :title, presence: true

  def notes
    basic_notes.order(:ordinal_position)
  end

  def notes_count
    basic_notes.count
  end
end
