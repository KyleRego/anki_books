# frozen_string_literal: true

class RemoveBlobIdFromActiveVariantRecords < ActiveRecord::Migration[7.0]
  def change
    remove_column :active_storage_variant_records, :blob_id, :bigint
  end
end
