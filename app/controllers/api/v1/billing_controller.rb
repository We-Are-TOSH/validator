module Api
  module V1
    class BillingController < ApplicationController
      before_action :authenticate_client

      def monthly_summary
        month = params[:month] ? Date.parse(params[:month]) : Date.current
        summary = BillingService.generate_monthly_summary(current_client, month)

        render json: { status: "success", summary: summary }
      end

      def credit_balance
        balance = {
          current_balance: current_client.current_balance,
          balance_history: current_client.credit_balances
            .order(created_at: :desc)
            .limit(10)
        }

        render json: { status: "success", balance: balance }
      end
    end
  end
end
