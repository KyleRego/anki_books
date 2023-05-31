# frozen_string_literal: true

class MakeActiveStorageVariantRecordsIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TABLE active_storage_variant_records ADD PRIMARY KEY (id);
    SQL
  end
end
