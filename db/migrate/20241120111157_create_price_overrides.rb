class CreatePriceOverrides < ActiveRecord::Migration[7.0]
  def change
    create_table :price_overrides do |t|
      t.references :client, null: false, foreign_key: true
      t.string :service_type, null: false
      t.decimal :markup_percentage, null: false
      t.timestamps
    end

    add_index :price_overrides, [:client_id, :service_type], unique: true
  end
end
