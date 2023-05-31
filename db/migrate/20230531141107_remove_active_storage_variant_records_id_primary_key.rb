# frozen_string_literal: true

class RemoveActiveStorageVariantRecordsIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :active_storage_variant_records, :id, :bigint, primary_key: true
  end
end
