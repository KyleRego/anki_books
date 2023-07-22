# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id         :uuid             not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Domain < ApplicationRecord
  belongs_to :user, optional: false
  has_many :books_domains, dependent: :destroy
  has_many :books, -> { order(:title) }, through: :books_domains

  validates :title, presence: true
end
