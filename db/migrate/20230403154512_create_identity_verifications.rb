class CreateIdentityVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :identity_verifications do |t|
      t.string :firstnames
      t.string :lastname
      t.date :dob
      t.integer :age
      t.string :gender
      t.string :citizenship
      t.datetime :date_issued
      t.string :transaction_id

      t.timestamps
    end
  end
end
