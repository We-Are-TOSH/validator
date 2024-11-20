class CreditBalance < ApplicationRecord
  belongs_to :client

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  scope :active, -> { where(expired_at: nil) }

  def self.add_credits(client, amount, description)
    create!(
      client: client,
      amount: amount,
      description: description
    )
  end

  def self.deduct_credits(client, amount, description)
    create!(
      client: client,
      amount: -amount,
      description: description
    )
  end
end
