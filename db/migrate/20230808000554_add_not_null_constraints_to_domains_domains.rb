# frozen_string_literal: true

class AddNotNullConstraintsToDomainsDomains < ActiveRecord::Migration[7.0]
  def change
    change_column_null :domains_domains, :parent_domain_id, false
    change_column_null :domains_domains, :child_domain_id, false
  end
end
