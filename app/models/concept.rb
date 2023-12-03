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
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Concept < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user, case_sensitive: false }

  before_save { self.name = name.strip }

  belongs_to :user, optional: false

  has_many :concepts_notes, dependent: :destroy
  has_many :notes, through: :concepts_notes

  scope :ordered, -> { order(:name) }
end
