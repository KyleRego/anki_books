# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: basic_notes
#
#  id               :uuid             not null, primary key
#  front            :text
#  back             :text
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
TEST_BASIC_NOTE_FRONT = "What sound does a cat make?"
TEST_BASIC_NOTE_BACK = "The cat says meow."

FactoryBot.define do
  factory :basic_note do
    front { TEST_BASIC_NOTE_FRONT }
    back { TEST_BASIC_NOTE_BACK }
    ordinal_position { article&.basic_notes_count }
  end
end
