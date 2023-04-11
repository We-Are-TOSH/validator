require 'http'

class ValidateIdService
  API_URL = ENV['SA_ID_VERIFICATION'].freeze

  def self.validate_id(api_key, id_number)
    response = HTTP.post(API_URL,
                         form: {
                           api_key: api_key,
                           id_number: id_number
                         }
    )

    if response.status.success?
      JSON.parse(response.body.to_s)
    else
      raise "Error validating ID number: #{response.body}"
    end
  end
end
