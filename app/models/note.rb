# frozen_string_literal: true

# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

##
# Single-table inheritance model for note classes
class Note < ApplicationRecord
  include AnkiGuidable

  validate :validate_correct_attributes_for_note_type
  validates :ordinal_position, presence: true,
                               uniqueness: { scope: :article_id },
                               numericality: { greater_than_or_equal_to: 0 }

  belongs_to :article

  has_many :concepts_notes, dependent: :destroy
  has_many :concepts, through: :concepts_notes

  scope :basic, -> { where(type: "BasicNote") }
  scope :cloze, -> { where(type: "ClozeNote") }

  scope :ordered, -> { order(:ordinal_position) }

  private

  def validate_correct_attributes_for_note_type
    if type == "BasicNote"
      errors.add(:front, "can't be blank") if front.blank?
      errors.add(:back, "can't be blank") if back.blank?
    elsif type == "ClozeNote"
      errors.add(:sentence, "can't be blank") if sentence.blank?
    end
  end
end
