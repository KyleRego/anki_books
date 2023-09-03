# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# A concept is used to generate cloze deletion cards from the long-text
# its associated article.
class Concept < ApplicationRecord
  belongs_to :user, optional: false

  belongs_to :parent_concept, optional: true, class_name: "Concept", inverse_of: :concepts
  has_many :concepts, foreign_key: :parent_domain_id, inverse_of: :parent_domain, dependent: nil

  validates :name, presence: true

  before_save { self.name = name.strip }
end
