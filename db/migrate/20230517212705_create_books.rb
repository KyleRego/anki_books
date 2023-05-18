# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :title

      t.timestamps
    end
  end
end
