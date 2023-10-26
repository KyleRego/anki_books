# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

ClozeSentenceConcepts = Struct.new("ClozeSentenceConcepts", :sentence, :concepts, :cloze_note_synced)

# == Schema Information
#
# Table name: articles
#
#  id               :uuid             not null, primary key
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  system           :boolean          default(FALSE), not null
#  book_id          :uuid             not null
#  ordinal_position :integer          not null
#  reading          :boolean          default(TRUE), not null
#  writing          :boolean          default(FALSE), not null
#  complete         :boolean          default(FALSE), not null
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#
class Article < ApplicationRecord
  include Article::SyncToClozeNotes
  include Article::HasManyOrdinalChildren

  belongs_to :book

  has_rich_text :content

  has_many :basic_notes, dependent: :destroy
  has_many :cloze_notes, dependent: :destroy

  validates :title, presence: true
  validates :ordinal_position, presence: true, uniqueness: { scope: :book_id }

  scope :ordered, -> { order(:ordinal_position) }

  delegate :count, to: :basic_notes, prefix: true
end
