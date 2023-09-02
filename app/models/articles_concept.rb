# frozen_string_literal: true

# :nodoc:
class ArticlesConcept < ApplicationRecord
  belongs_to :article
  belongs_to :concept
end
