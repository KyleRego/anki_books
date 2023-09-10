# frozen_string_literal: true

# == Schema Information
#
# Table name: cloze_notes
#
#  id         :uuid             not null, primary key
#  sentence   :text             not null
#  article_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#

TEST_SENTENCE = "Cloze note test sentence."

FactoryBot.define do
  factory :cloze_note do
    sentence { TEST_SENTENCE }
  end
end
