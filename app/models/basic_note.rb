# frozen_string_literal: true

##
# Represents a note of the default Basic Anki note type.
class BasicNote < ApplicationRecord
  include AnkiTimestampable
  include AnkiGuidable

  include BasicNote::TurboFrameable

  include ERB::Util
  include Rails.application.routes.url_helpers

  before_validation :set_anki_id_if_nil, :set_anki_guid_if_nil

  belongs_to :article

  validates :front, presence: true
  validates :back, presence: true
  validates :anki_id, presence: true, numericality: { only_integer: true }, length: { is: 13 }
  validates :anki_guid, presence: true, uniqueness: true
  validates :ordinal_position, presence: true, uniqueness: { scope: :article_id }

  def anki_front
    format_for_input_to_anki(field: front)
  end

  def anki_back
    content = format_for_input_to_anki(field: back)
    "#{content}<br><br>#{note_link}"
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

  def note_link
    "<a href=\"#{article_url(article)}##{turbo_id}\">Edit</a>"
  end
end
