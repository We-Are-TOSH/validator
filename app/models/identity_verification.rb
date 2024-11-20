class IdentityVerification < ApplicationRecord
  include Encryption

  encrypts :id_number
  encrypts :verification_data

  validates :id_number, presence: true
  validates :verification_data, presence: true

  after_create :schedule_deletion

  def verification_valid?
    verified_at && verified_at > 30.days.ago
  end

  private

  def schedule_deletion
    DeleteVerificationJob.set(wait: 30.days).perform_later(id)
  end
end
