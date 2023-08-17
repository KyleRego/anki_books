# frozen_string_literal: true

class DropDomainsDomains < ActiveRecord::Migration[7.0]
  def change
    drop_table :domains_domains
  end
end
