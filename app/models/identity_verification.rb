class IdentityVerification < ApplicationRecord
  self.primary_key = 'id_number'
  validates :id_number, presence: true, uniqueness: true
  validates :dob, :lastname, :citizenship, presence: true

  before_save :hash_sensitive_data

  attr_accessor :id_number_salt, :lastname_salt, :dob_salt, :citizenship_salt, :id_number_hashed, :lastname_hashed, :dob_hashed, :citizenship_hashed

  def unhashed_id_number
    Digest::SHA256.hexdigest(id_number_salt + id_number_hashed)
  end

  def unhashed_lastname
    Digest::SHA256.hexdigest(lastname_salt + lastname_hashed)
  end

  def unhashed_dob
    Digest::SHA256.hexdigest(dob_salt + dob.to_s)
  end

  def unhashed_citizenship
    Digest::SHA256.hexdigest(citizenship_salt + citizenship_hashed)
  end

  private

  def hash_sensitive_data
    self.id_number_salt = SecureRandom.hex(32)
    self.lastname_salt = SecureRandom.hex(32)
    self.dob_salt = SecureRandom.hex(32)
    self.citizenship_salt = SecureRandom.hex(32)

    self.id_number_hashed = Digest::SHA256.hexdigest(id_number_salt + id_number)
    self.lastname_hashed = Digest::SHA256.hexdigest(lastname_salt + lastname)
    self.dob_hashed = Digest::SHA256.hexdigest(dob_salt + dob.to_s)
    self.citizenship_hashed = Digest::SHA256.hexdigest(citizenship_salt + citizenship)
  end
end
