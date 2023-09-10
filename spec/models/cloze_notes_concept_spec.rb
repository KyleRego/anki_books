# frozen_string_literal: true

# == Schema Information
#
# Table name: cloze_notes_concepts
#
#  id            :uuid             not null, primary key
#  cloze_note_id :uuid             not null
#  concept_id    :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (cloze_note_id => cloze_notes.id)
#  fk_rails_...  (concept_id => concepts.id)
#

RSpec.describe ClozeNotesConcept
