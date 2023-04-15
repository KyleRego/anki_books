# frozen_string_literal: true

##
# Articles represent where the user can write long-form text content.
class Article < ApplicationRecord
  has_rich_text :content
end
