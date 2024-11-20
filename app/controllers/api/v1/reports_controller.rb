module Api
  module V1
    class ReportsController < ApplicationController
      before_action :authenticate_client

      def usage
        start_date = params[:start_date] ? Date.parse(params[:start_date]) : 30.days.ago
        end_date = params[:end_date] ? Date.parse(params[:end_date]) : Date.current

        report = UsageReportService.generate_report(current_client, start_date, end_date)
        render json: { status: "success", report: report }
      end

      def trends
        trends = UsageTrendService.analyze_client_trends(current_client)
        render json: { status: 'success', trends: trends }
      end
    end
  end
end
