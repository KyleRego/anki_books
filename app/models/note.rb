# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id               :uuid             not null, primary key
#  front            :text
#  back             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  article_id       :uuid             not null
#  ordinal_position :integer          not null
#  anki_guid        :string           not null
#  type             :string           not null
#  sentence         :text
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
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

  # rubocop:disable Style/IfInsideElse
  def validate_correct_attributes_for_note_type
    if type == "BasicNote"
      errors.add(:front, "can't be blank") if front.blank?
      errors.add(:back, "can't be blank") if back.blank?
    else
      errors.add(:sentence, "can't be blank") if sentence.blank?
    end
  end
  # rubocop:enable Style/IfInsideElse

  public

  def self.new_ordinal_position_zero_note_turbo_id
    "article-first-new-note"
  end

  def turbo_dom_id
    "note-#{id}"
  end

  def new_next_note_sibling_after_note_turbo_id
    "new-next-note-sibling-after-note-#{id}"
  end
end
