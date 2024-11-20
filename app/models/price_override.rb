class PriceOverride < ApplicationRecord
  belongs_to :client

  validates :service_type, presence: true
  validates :markup_percentage, presence: true, numericality: { greater_than: 0 }
end
