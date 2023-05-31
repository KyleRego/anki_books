# frozen_string_literal: true

class RemoveBlobIdIndexFromActiveStorageVariantRecords < ActiveRecord::Migration[7.0]
  def change
    remove_index :active_storage_variant_records, name: :index_active_storage_variant_records_uniqueness
  end
end
