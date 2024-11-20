class ValidateIdController < ApplicationController

  def get_identity_verification
    id_number = params[:id_number]

    # Check if the ID is in the database
    existing_identity_verification = IdentityVerification.find_by(id_number: id_number)
    if existing_identity_verification.present?
      data = {
        Firstnames: existing_identity_verification.firstnames,
        Lastname: existing_identity_verification.lastname,
        Dob: existing_identity_verification.dob,
        Age: existing_identity_verification.age,
        Gender: existing_identity_verification.gender,
        Citizenship: existing_identity_verification.citizenship,
        DateIssued: existing_identity_verification.date_issued
      }
      render json: { Status: 'ID Number Valid', Verification: data }
    else
      validate
    end
  end

  private

  def validate
    id_number = params[:id_number]
    client = authenticate_client
    # If the ID does not exist, make an API request
    api_key = ENV['VERIFYID_API_KEY']
    result = ValidateIdService.new(client, params[:id_number]).execute

    render json: result, status: :ok
      rescue InsufficientCreditsError => e
        render json: {
          status: 'error',
          message: e.message
        }, status: :payment_required

    # Save the API response data to the database
    verification_data = result['Verification']
    identity_verification = IdentityVerification.create!(
      id_number: id_number,
      firstnames: verification_data['Firstnames'],
      lastname: verification_data['Lastname'],
      dob: verification_data['Dob'],
      age: verification_data['Age'],
      gender: verification_data['Gender'],
      citizenship: verification_data['Citizenship'],
      date_issued: verification_data['DateIssued']
    )

    # Return unified data
    data = {
      Firstnames: verification_data['Firstnames'],
      Lastname: verification_data['Lastname'],
      Dob: verification_data['Dob'],
      Age: verification_data['Age'],
      Gender: verification_data['Gender'],
      Citizenship: verification_data['Citizenship'],
      DateIssued: verification_data['DateIssued']
    }
    render json: { Status: result['Status'], Verification: data }
  rescue StandardError => e
    render json: { error: { Status: 'ID Number Invalid' } }
  end
end
