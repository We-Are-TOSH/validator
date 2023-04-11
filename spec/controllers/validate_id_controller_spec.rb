require 'rails_helper'

RSpec.describe ValidateIdController, type: :controller do
  describe "GET get_identity_verification" do
    context "when ID exists in database" do
      let(:id_verification) { FactoryBot.create(:identity_verification) }

      before do
        get :get_identity_verification, params: { id_number: id_verification.id_number }
      end

      it 'returns a JSON with existing identity verification data' do
        json_response = JSON.parse(response.body)
        expect(json_response['firstnames']).to eq(id_verification.firstnames)
        expect(json_response['lastname']).to eq(id_verification.lastname)
        expect(json_response['dob']).to eq(id_verification.dob.to_s)
        expect(json_response['gender']).to eq(id_verification.gender)
        expect(json_response['citizenship']).to eq(id_verification.citizenship)
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context "when ID does not exist in database" do
      let(:id_number) { "9202185307082" }
      let(:result) do
        {
          "Status" => "VALID",
          "Verification" => {
            "Firstnames" => "John Doe",
            "Lastname" => "Doe",
            "Dob" => "1992-02-18",
            "Age" => 29,
            "Gender" => "M",
            "Citizenship" => "SA",
            "DateIssued" => "2020-01-01"
          },
          "transaction_id" => "123456"
        }
      end

      before do
        allow(ValidateIdService).to receive(:validate_id).and_return(result)
        get :get_identity_verification, params: { id_number: id_number }
      end

      it "returns a JSON with API verification data" do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(result)
      end

      it "creates a new IdentityVerification record" do
        expect(IdentityVerification.find_by(id_number: id_number)).not_to be_nil
      end
    end

    context "when there is an error" do
      let(:error) { StandardError.new("API Error") }

      before do
        allow(ValidateIdService).to receive(:validate_id).and_raise(error)
        get :get_identity_verification, params: { id_number: "9202185307082" }
      end

      it "returns a JSON with an error message" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ "error" => "API Error" })
      end
    end
  end
end
