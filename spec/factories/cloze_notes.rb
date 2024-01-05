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

TEST_SENTENCE = "Cloze note test sentence."

FactoryBot.define do
  factory :cloze_note do
    sentence { TEST_SENTENCE }
    ordinal_position { article&.notes_count }
  end
end
