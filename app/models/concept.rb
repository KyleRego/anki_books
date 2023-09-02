# frozen_string_literal: true

##
# A concept is used to generate cloze deletion cards from the long-text
# its associated article.
class Concept < ApplicationRecord
  belongs_to :user, optional: false

  belongs_to :parent_concept, optional: true, class_name: "Concept", inverse_of: :concepts
  has_many :concepts, foreign_key: :parent_domain_id, inverse_of: :parent_domain, dependent: nil

  has_many :articles_concepts, dependent: :destroy
  has_many :articles, through: :articles_concepts
end
