# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

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
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#
class Article < ApplicationRecord
  belongs_to :book

  has_rich_text :content

  has_many :basic_notes, dependent: :destroy
  has_many :ordered_notes, -> { order(:ordinal_position) }, class_name: "BasicNote", inverse_of: :article, dependent: :destroy

  has_many :cloze_notes, dependent: :destroy

  validates :title, presence: true
  validates :ordinal_position, presence: true, uniqueness: { scope: :book_id }

  def notes_count
    basic_notes.count
  end

  ##
  # Returns an array of strings which are the matching sentences
  # of the article for the string +concept_name+
  def cloze_sentences(concept_name:)
    article_content = content.to_plain_text
    regex_for_concept = cloze_sentence_regex(concept_name:)
    article_content.scan(regex_for_concept).flatten
  end

  private

  CLOZE_SENTENCE_START = /(?<=\A|\n|\. )/
  CLOZE_SENTENCE_END = /\."?/

  def cloze_sentence_regex(concept_name:)
    /#{CLOZE_SENTENCE_START}[^.\n]*\b#{concept_name}\b[^.\n]*#{CLOZE_SENTENCE_END}/
  end
end
