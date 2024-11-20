require 'prometheus/client'

class ValidationMetrics
  class << self
    def registry
      @registry ||= Prometheus::Client.registry
    end

    def counter
      @counter ||= registry.counter(
        :id_validations_total,
        'Total number of ID validations performed'
      )
    end

    def duration
      @duration ||= registry.histogram(
        :id_validation_duration_seconds,
        'Time spent validating IDs',
        buckets: [0.1, 0.25, 0.5, 1, 2.5, 5, 10]
      )
    end

    def error_counter
      @error_counter ||= registry.counter(
        :id_validation_errors_total,
        'Total number of validation errors'
      )
    end
  end
end

VALIDATION_METRICS = ValidationMetrics
