class ApiKey < ApplicationRecord
  belongs_to :client

  before_create :generate_key

  scope :active, -> { where(revoked_at: nil) }

  def revoke!
    update!(revoked_at: Time.current)
  end

  private

  def generate_key
    self.key = SecureRandom.hex(32)
  end
end
