class CreateArticles < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :articles, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :title

      t.timestamps
    end
  end
end
