# frozen_string_literal: true

##
# Represents a note of the default Basic Anki note type.
class BasicNote < ApplicationRecord
  include AnkiRecord::Helpers::TimeHelper

  before_validation :set_anki_id_if_nil

  belongs_to :article

  validates :front, presence: true
  validates :back, presence: true
  validates :anki_id, presence: true, numericality: { only_integer: true }, length: { is: 13 }

  private

  def set_anki_id_if_nil
    self.anki_id ||= milliseconds_since_epoch
  end
end
