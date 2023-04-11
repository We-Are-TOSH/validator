require 'http'

class GenerateApiKeyService
  API_URL = 'https://www.verifyid.co.za/webservice/generate_api_key'.freeze
  API_KEY_CACHE_KEY = ENV['VERIFYID_API_KEY'].freeze
  API_KEY_EXPIRATION_TIME = 40.day

  def self.get_or_generate_api_key
    # Attempt to get the API key from the cache
    api_key = Rails.cache.read(API_KEY_CACHE_KEY)

    # If the API key is not in the cache, generate a new one and store it
    unless api_key
      api_key = generate_api_key
      Rails.cache.write(API_KEY_CACHE_KEY, api_key, expires_in: API_KEY_EXPIRATION_TIME)
    end

    api_key
  end

  def self.generate_api_key
    email_address = ENV['VERIFYID_EMAIL_ADDRESS']
    password = ENV['VERIFYID_PASSWORD']

    response = HTTP.post(API_URL,
                         form: {
                           email_address: email_address,
                           password: password
                         }
    )

    if response.status.success?
      JSON.parse(response.body.to_s)['Result']['API_KEY']
    else
      raise "Error generating API key: #{response.body}"
    end
  end
end
