# frozen_string_literal: true

##
# Articles represent where the user can write long-form text content.
class Article < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true

  def title_slug
    title.parameterize
  end
end
