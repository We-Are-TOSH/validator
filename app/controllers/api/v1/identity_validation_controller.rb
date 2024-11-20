module Api
  module V1
    class IdentityValidationController < ApplicationController
      include ErrorHandler
      include Logging

      before_action :authenticate_client
      before_action :validate_params

      def validate
        start_time = Time.current

        result = ValidateIdService.new(validation_params).execute

        log_validation_metrics(start_time)
        render json: result, status: :ok
      rescue IdValidatorError => e
        log_error('Validation failed', e)
        render_error(:bad_request, e.message)
      rescue ApiError => e
        log_error('External API error', e)
        render_error(:service_unavailable, 'Service temporarily unavailable')
      end

      private

      def validation_params
        params.require(:id_number)
      end

      def authenticate_client
        api_key = request.headers['X-API-Key']
        return if ApiClient.valid_key?(api_key)

        render_error(:unauthorized, 'Invalid API key')
      end

      def log_validation_metrics(start_time)
        duration = Time.current - start_time
        VALIDATION_METRICS.duration.observe(duration)
        VALIDATION_METRICS.counter.increment
      end
    end
  end
end
