class ValidateIdService
  include Logging

  def initialize(client, id_number)
    @client = client
    @id_number = id_number
  end

  def execute
    validate_id_format
    cached_result = fetch_from_cache
    return cached_result if cached_result.present?

    result = fetch_from_api
    cache_result(result)
    result

    validate_client_credits!

    local_result = check_local_database
    return local_result if local_result

    fetch_from_verify_id
  end

  private

  def validate_client_credits!
    service_type = :identity_verification
    pricing = PricingService.calculate_price(service_type)

    unless @client.can_perform_service?(service_type)
      raise InsufficientCreditsError, "Not enough credits to perform verification"
    end
  end

  def check_local_database
    existing_verification = IdentityVerification.find_by(id_number: @id_number)

    if existing_verification && existing_verification.verification_valid?
      {
        status: 'ID Number Valid',
        verification: existing_verification.verification_data,
        source: 'local_database'
      }
    else
      nil
    end
  end

  def fetch_from_verify_id
    api_key = GenerateApiKeyService.get_or_generate_api_key
    result = VerifyIdApi.validate_id(api_key, @id_number)

    save_verification(result)

    deduct_client_credits

    {
      status: result['Status'],
      verification: result['Verification'],
      source: 'verify_id_api'
    }
  end

  def save_verification(result)
    IdentityVerification.create!(
      id_number: @id_number,
      verification_data: result['Verification'],
      verified_at: Time.current
    )
  end

  def deduct_client_credits
    service_type = :identity_verification
    pricing = PricingService.calculate_price(service_type)

    CreditBalance.deduct_credits(
      @client,
      pricing[:credits_required],
      "ID Verification for #{@id_number}"
    )
  end

  def validate_id_format
    return if IdValidator.valid_format?(@id_number)

    raise IdValidatorError, 'Invalid ID number format'
  end

  def fetch_from_cache
    Rails.cache.read(cache_key)
  end

  def fetch_from_api
    api_key = GenerateApiKeyService.get_or_generate_api_key
    result = ValidateIdApi.validate(@id_number, api_key)

    save_to_database(result)
    format_response(result)
  end

  def cache_key
    "id_validation:#{@id_number}"
  end

  def cache_result(result)
    Rails.cache.write(cache_key, result, expires_in: 24.hours)
  end

  def save_to_database(result)
    IdentityVerification.create!(
      id_number: @id_number,
      verification_data: result,
      verified_at: Time.current
    )
  end

  def format_response(result)
    {
      status: 'success',
      data: {
        id_number: @id_number,
        verification: result,
        verified_at: Time.current
      }
    }
  end
end
