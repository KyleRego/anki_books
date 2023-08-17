# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id               :uuid             not null, primary key
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  parent_domain_id :uuid
#
# Foreign Keys
#
#  fk_rails_...  (parent_domain_id => domains.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :domain do
    title { "domain title" }
    user { nil }
  end
end
