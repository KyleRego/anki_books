# frozen_string_literal: true

##
# Articles represent where the user can write long-form text content.
class Article < ApplicationRecord
  has_rich_text :content
  has_many :basic_notes, dependent: :destroy

  validates :title, presence: true

  def notes_count
    basic_notes.count
  end

  def title_slug
    title.parameterize
  end
end
