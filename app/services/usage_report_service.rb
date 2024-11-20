class UsageReportService
  def self.generate_report(client, start_date = 30.days.ago, end_date = Date.current)
    transactions = client.transactions
      .where(created_at: start_date..end_date)

    {
      period: {
        start_date: start_date,
        end_date: end_date
      },
      summary: {
        total_transactions: transactions.count,
        total_amount: transactions.sum(:charged_amount),
        total_credits: transactions.sum(:credits_used)
      },
      by_service: service_breakdown(transactions),
      daily_usage: daily_breakdown(transactions)
    }
  end

  private

  def self.service_breakdown(transactions)
    transactions.group(:service_type)
      .select('service_type,
               COUNT(*) as count,
               SUM(charged_amount) as total_amount,
               SUM(credits_used) as total_credits')
      .map(&:attributes)
  end

  def self.daily_breakdown(transactions)
    transactions.group_by_day(:created_at)
      .select('DATE(created_at) as date,
               COUNT(*) as count,
               SUM(charged_amount) as total_amount')
      .map(&:attributes)
  end
end
