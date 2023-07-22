# frozen_string_literal: true

# == Schema Information
#
# Table name: basic_notes
#
#  id               :uuid             not null, primary key
#  front            :text
#  back             :text
#  anki_id          :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  article_id       :uuid             not null
#  ordinal_position :integer          not null
#  anki_guid        :string           not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
class BasicNote < ApplicationRecord
  include AnkiTimestampable
  include AnkiGuidable

  include BasicNote::AnkiContentable
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

  private

  def set_anki_id_if_nil
    self.anki_id ||= anki_milliseconds_timestamp
  end

  def set_anki_guid_if_nil
    self.anki_guid ||= anki_globally_unique_id
  end
end
