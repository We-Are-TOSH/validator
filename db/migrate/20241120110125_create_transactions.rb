class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :client, null: false, foreign_key: true
      t.string :service_type, null: false
      t.decimal :base_amount, null: false
      t.decimal :charged_amount, null: false
      t.timestamps
    end
  end
end
