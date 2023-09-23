# frozen_string_literal: true

# == Schema Information
#
# Table name: concepts
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :concept do
    name { Faker::Emotion.unique.noun }
    user { nil }
  end
end
