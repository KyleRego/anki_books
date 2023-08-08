# frozen_string_literal: true

class CreateJoinTableDomainsDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains_domains, id: :uuid do |t|
      t.uuid :parent_domain_id
      t.uuid :child_domain_id

      t.timestamps
    end
  end
end
