# frozen_string_literal: true

class AddForeignKeysToDomainsDomains < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :domains_domains, :domains, column: :parent_domain_id
    add_foreign_key :domains_domains, :domains, column: :child_domain_id
  end
end
