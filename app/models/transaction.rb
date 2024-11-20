class Transaction < ApplicationRecord
  belongs_to :client

  def self.create_for_service(client, service_type)
    pricing = PricingService.calculate_price(service_type)

    create!(
      client: client,
      service_type: service_type,
      base_price: pricing[:base_price],
      charged_amount: pricing[:final_price],
      credits_used: pricing[:credits_required],
      description: pricing[:description]
    )
  end
end
