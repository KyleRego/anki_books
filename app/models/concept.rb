# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

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
