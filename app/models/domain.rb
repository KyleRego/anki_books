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

  has_many :parent_domains_domains, class_name: "DomainsDomain", foreign_key: :parent_domain_id, inverse_of: :child_domain,
                                    dependent: :destroy
  has_many :child_domains_domains, class_name: "DomainsDomain", foreign_key: :child_domain_id, inverse_of: :parent_domain,
                                   dependent: :destroy

  has_many :parent_domains, through: :parent_domains_domains, class_name: "Domain"
  has_many :child_domains, through: :child_domains_domains, class_name: "Domain"

  validates :title, presence: true
end
