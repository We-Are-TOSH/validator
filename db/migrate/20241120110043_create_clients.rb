class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.decimal :markup_percentage, null: false, default: 30.0
      t.text :description
      t.timestamps
    end

    add_index :clients, :name, unique: true
  end
end
