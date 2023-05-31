# frozen_string_literal: true

class UpdateNewForeignKeyUuids < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE active_storage_attachments
      SET tmp_record_id = (
        SELECT tmp_id
        FROM action_text_rich_texts
        WHERE active_storage_attachments.record_id = action_text_rich_texts.id
      )
      WHERE active_storage_attachments.record_type = 'ActionText::RichText';
    SQL

    execute <<-SQL
      UPDATE active_storage_attachments
      SET tmp_record_id = (
        SELECT tmp_id
        FROM active_storage_variant_records
        WHERE active_storage_attachments.record_id = active_storage_variant_records.id
      )
      WHERE active_storage_attachments.record_type = 'ActiveStorage::VariantRecord';
    SQL

    execute <<-SQL
      UPDATE active_storage_attachments
      SET tmp_blob_id = (
        SELECT tmp_id
        FROM active_storage_blobs
        WHERE active_storage_attachments.blob_id = active_storage_blobs.id
      );
    SQL

    execute <<-SQL
      UPDATE active_storage_variant_records
      SET tmp_blob_id = (
        SELECT tmp_id
        FROM active_storage_blobs
        WHERE active_storage_variant_records.blob_id = active_storage_blobs.id
      );
    SQL
  end

  def down
    execute <<-SQL
      UPDATE active_storage_attachments
      SET tmp_record_id = NULL;
    SQL

    execute <<-SQL
      UPDATE active_storage_attachments
      SET tmp_blob_id = NULL;
    SQL

    execute <<-SQL
      UPDATE active_storage_variant_records
      SET tmp_blob_id = NULL;
    SQL
  end
end
