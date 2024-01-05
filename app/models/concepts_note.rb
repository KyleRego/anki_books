# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: concepts_notes
#
#  id         :uuid             not null, primary key
#  note_id    :uuid             not null
#  concept_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (concept_id => concepts.id)
#  fk_rails_...  (note_id => notes.id)
#
class ConceptsNote < ApplicationRecord
  belongs_to :note
  belongs_to :concept
end
