# frozen_string_literal: true

# :nodoc:
class Article < ApplicationRecord
  belongs_to :book, optional: true
  has_rich_text :content
  has_many :basic_notes, dependent: :destroy
  has_many :ordered_notes, -> { order(:ordinal_position) }, class_name: "BasicNote", inverse_of: :article, dependent: :destroy

  validates :title, presence: true
  validates :ordinal_position, presence: true, uniqueness: { scope: :book_id }

  def notes_count
    basic_notes.count
  end
end
