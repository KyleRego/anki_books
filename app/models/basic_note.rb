# frozen_string_literal: true

##
# Represents a note of the default Basic Anki note type.
class BasicNote < ApplicationRecord
  include AnkiTimestampable
  include AnkiGuidable

  before_validation :set_anki_id_if_nil, :set_anki_guid_if_nil

  belongs_to :article

  validates :front, presence: true
  validates :back, presence: true
  validates :anki_id, presence: true, numericality: { only_integer: true }, length: { is: 13 }
  validates :ordinal_position, presence: true, uniqueness: { scope: :article_id }

  private

  def set_anki_id_if_nil
    self.anki_id ||= anki_milliseconds_timestamp
  end

  def set_anki_guid_if_nil
    self.anki_guid ||= anki_globally_unique_id
  end
end
