class Client < ApplicationRecord
  has_many :api_keys
  has_many :transactions
  has_many :credit_balances
  has_many :price_overrides

  validates :name, presence: true, uniqueness: true

  def current_balance
    credit_balances.active.sum(:amount)
  end

  def can_perform_service?(service_type)
    pricing = PricingService.calculate_price(service_type, self)
    current_balance >= pricing[:credits_required]
  end

  def get_custom_price(service_type)
    override = price_overrides.find_by(service_type: service_type)
    override&.markup_percentage || PricingService::DEFAULT_MARKUP
  end
end
