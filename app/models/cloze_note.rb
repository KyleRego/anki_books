# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Represents an Anki cloze note
# == Schema Information
#
# Table name: cloze_notes
#
#  id         :uuid             not null, primary key
#  sentence   :text             not null
#  article_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
class ClozeNote < ApplicationRecord
  include AnkiGuidable

  before_validation :set_anki_guid_if_nil

  belongs_to :article

  has_many :cloze_notes_concepts, dependent: :destroy
  has_many :concepts, through: :cloze_notes_concepts

  def anki_sentence
    result = sentence
    concepts.order(:name).each_with_index do |concept, index|
      result = result.gsub(concept.name, "{{c#{index + 1}::#{concept.name}}}")
    end
    result
  end

  private

  def set_anki_guid_if_nil
    self.anki_guid ||= anki_globally_unique_id
  end
end
