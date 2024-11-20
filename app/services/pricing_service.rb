class PricingService
  CREDIT_VALUE = 1.15  # R1.15 per credit
  DEFAULT_MARKUP = 35.0  # 35% markup

  SERVICE_PRICES = {
    identity_verification: {
      credits: 13,
      base_price: 14.95,
      description: "Personal identity details verified"
    },
    marital_status: {
      credits: 13,
      base_price: 14.95,
      description: "Persons marital status verified"
    },
    biometric: {
      credits: 20,
      base_price: 23.00,
      description: "Personal biometrics, fingerprints and facial match/verification"
    },
    aml_check: {
      credits: 5,
      base_price: 5.70,
      description: "Anti Money Laundering (AML) and PEP Check"
    },
    kyc_basic: {
      credits: 7,
      base_price: 8.05,
      description: "KYC Verification - Basic"
    },
    kyc_with_dha: {
      credits: 14,
      base_price: 16.10,
      description: "KYC Verification with DHA Verification"
    },
    kyc_full: {
      credits: 21,
      base_price: 24.15,
      description: "KYC Verification with DHA and Address Verification"
    }
  }

  def self.calculate_price(service_type)
    service = SERVICE_PRICES[service_type.to_sym]
    raise "Unknown service type: #{service_type}" unless service

    base_price = service[:base_price]
    marked_up_price = base_price * (1 + (DEFAULT_MARKUP / 100.0))

    {
      service_type: service_type,
      description: service[:description],
      base_price: base_price,
      markup_percentage: DEFAULT_MARKUP,
      final_price: marked_up_price.round(2),
      credits_required: service[:credits]
    }
  end

  def self.get_all_prices
    SERVICE_PRICES.map do |service_type, _|
      calculate_price(service_type)
    end
  end
end
