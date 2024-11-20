class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.references :client, null: false, foreign_key: true
      t.string :key, null: false
      t.datetime :revoked_at
      t.timestamps
    end

    add_index :api_keys, :key, unique: true
  end
end
