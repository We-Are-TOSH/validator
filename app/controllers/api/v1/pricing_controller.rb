module Api
  module V1
    class PricingController < ApplicationController
      def index
        prices = PricingService.get_all_prices
        render json: {
          status: "success",
          pricing: prices
        }
      end
    end
  end
end
