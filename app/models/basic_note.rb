# frozen_string_literal: true

##
# Represents a note of the default Basic Anki note type.
class BasicNote < ApplicationRecord
  include AnkiTimestampable
  include AnkiGuidable
  include ERB::Util

  before_validation :set_anki_id_if_nil, :set_anki_guid_if_nil

  belongs_to :article

  validates :front, presence: true
  validates :back, presence: true
  validates :anki_id, presence: true, numericality: { only_integer: true }, length: { is: 13 }
  validates :anki_guid, presence: true, uniqueness: true
  validates :ordinal_position, presence: true, uniqueness: { scope: :article_id }

  # TODO: Could it be worth denormalizing the front and back by storing
  # anki_front and anki_back values in the table?
  def anki_front
    format_for_input_to_anki(field: front)
  end

  def anki_back
    format_for_input_to_anki(field: back)
  end

  private

  def set_anki_id_if_nil
    self.anki_id ||= anki_milliseconds_timestamp
  end

  def set_anki_guid_if_nil
    self.anki_guid ||= anki_globally_unique_id
  end

  def format_for_input_to_anki(field:)
    html_escape(field).gsub("\n", "<br>")
  end
end
