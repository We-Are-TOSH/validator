class UpdateIdentityVerifications < ActiveRecord::Migration[7.0]
  def change
    add_column :identity_verifications, :verification_data, :jsonb
    add_column :identity_verifications, :verified_at, :datetime
    add_index :identity_verifications, :verified_at
  end
end
