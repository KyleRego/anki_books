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
#  anki_guid  :string           not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
class ClozeNote < ApplicationRecord
  include AnkiGuidable

  include ClozeNote::AnkiContentable
  include ClozeNote::TurboFrameable

  # TODO: See if this (and same in Basic Note)
  # can be included into the module where they are used
  # is used instead rather than here (AnkiContentable)
  include ERB::Util
  include Rails.application.routes.url_helpers

  belongs_to :article

  has_many :cloze_notes_concepts, dependent: :destroy
  has_many :concepts, through: :cloze_notes_concepts

  validates :sentence, presence: true
end
