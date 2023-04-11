require 'http'

class CheckCreditsService
  API_URL = 'https://www.verifyid.co.za/webservice/my_credits'.freeze

  def self.check_credits(api_key)
    response = HTTP.get(API_URL, params: { api_key: api_key })

    if response.status.success?
      JSON.parse(response.body.to_s)['Result']['credits'].to_i
    else
      raise "Error checking credits: #{response.body}"
    end
  end

  def self.credits_count
    # code here
  end
end
