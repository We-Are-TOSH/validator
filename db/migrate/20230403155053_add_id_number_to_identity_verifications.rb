class AddIdNumberToIdentityVerifications < ActiveRecord::Migration[7.0]
  def change
    remove_column :identity_verifications, :id, :integer, if_exists: true
    add_column :identity_verifications, :id_number, :string, primary_key: true
  end
end
