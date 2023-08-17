# frozen_string_literal: true

class AddParentDomainIdToDomains < ActiveRecord::Migration[7.0]
  def change
    add_column :domains, :parent_domain_id, :uuid, null: true
    add_foreign_key :domains, :domains, column: :parent_domain_id, type: :uuid
  end
end
