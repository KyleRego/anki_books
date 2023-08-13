# frozen_string_literal: true

# == Schema Information
#
# Table name: domains_domains
#
#  id               :uuid             not null, primary key
#  parent_domain_id :uuid             not null
#  child_domain_id  :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (child_domain_id => domains.id)
#  fk_rails_...  (parent_domain_id => domains.id)
#
class DomainsDomain < ApplicationRecord
  belongs_to :parent_domain, class_name: "Domain"
  belongs_to :child_domain, class_name: "Domain"

  validate :domain_cannot_reference_self

  # TODO: Add a db constraint
  def domain_cannot_reference_self
    return unless parent_domain_id == child_domain_id

    errors.add(:parent_domain, "can't have itself as a child domain")
  end
end
