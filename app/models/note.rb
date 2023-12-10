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

  public

  # TODO: Unit tests on these, remove old tests
  def self.ordinal_position_zero_turbo_dom_id
    "article-first-new-note"
  end

  def turbo_dom_id
    "note-#{id}"
  end

  def new_next_note_sibling_after_note_turbo_id
    "new-next-note-sibling-after-note-#{id}"
  end
end
