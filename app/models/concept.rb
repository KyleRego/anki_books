# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# A concept is used to generate cloze deletion cards from the long-text
# its associated article--the concept name is the key word that becomes the
# fill in the blank of the sentence.
# == Schema Information
#
# Table name: concepts
#
#  id                :uuid             not null, primary key
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_concept_id :uuid
#  user_id           :uuid             not null
#
# Foreign Keys
#
#  fk_rails_...  (parent_concept_id => concepts.id)
#  fk_rails_...  (user_id => users.id)
#
class Concept < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user }

  before_save { self.name = name.strip }

  belongs_to :user, optional: false

  belongs_to :parent_concept, optional: true, class_name: "Concept", inverse_of: :concepts
  has_many :concepts, foreign_key: :parent_concept_id, inverse_of: :parent_concept, dependent: nil

  has_many :books_concepts, dependent: :destroy
  has_many :books, through: :books_concepts

  has_many :cloze_notes_concepts, dependent: :destroy
  has_many :cloze_notes, through: :cloze_notes_concepts

  scope :ordered, -> { order(:name) }
end
