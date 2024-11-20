module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      log_error(e)
      render_error(:internal_server_error, 'An unexpected error occurred')
    end

    rescue_from IdValidatorError do |e|
      log_error(e)
      render_error(:bad_request, e.message)
    end
  end

  private

  def render_error(status, message)
    render json: {
      status: 'error',
      error: {
        code: status,
        message: message
      }
    }, status: status
  end
end
