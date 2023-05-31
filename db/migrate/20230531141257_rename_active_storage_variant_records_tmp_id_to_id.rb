# frozen_string_literal: true

class RenameActiveStorageVariantRecordsTmpIdToId < ActiveRecord::Migration[7.0]
  def change
    rename_column :active_storage_variant_records, :tmp_id, :id
  end
end
