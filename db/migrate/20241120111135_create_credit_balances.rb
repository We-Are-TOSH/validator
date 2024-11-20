class CreateCreditBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_balances do |t|
      t.references :client, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.string :description
      t.datetime :expired_at
      t.timestamps
    end
  end
end
