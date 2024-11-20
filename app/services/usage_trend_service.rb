class UsageTrendService
  def self.analyze_client_trends(client, months = 6)
    transactions = client.transactions
      .where(created_at: months.months.ago..Date.current)
      .group_by_month(:created_at)

    service_trends = PricingService::SERVICE_PRICES.keys.map do |service_type|
      {
        service_type: service_type,
        monthly_usage: monthly_service_trend(client, service_type, months)
      }
    end

    {
      total_monthly_transactions: monthly_transaction_trend(transactions),
      total_monthly_revenue: monthly_revenue_trend(transactions),
      service_trends: service_trends,
      growth_rate: calculate_growth_rate(transactions)
    }
  end

  private

  def self.monthly_transaction_trend(transactions)
    transactions.count
  end

  def self.monthly_revenue_trend(transactions)
    transactions.sum(:charged_amount)
  end

  def self.monthly_service_trend(client, service_type, months)
    client.transactions
      .where(service_type: service_type)
      .group_by_month(:created_at)
      .count
  end

  def self.calculate_growth_rate(transactions)
    # Simple month-to-month revenue growth calculation
    monthly_revenues = transactions.map(&:sum_charged_amount)
    return 0 if monthly_revenues.size < 2

    ((monthly_revenues.last - monthly_revenues.first) / monthly_revenues.first * 100).round(2)
  end
end
