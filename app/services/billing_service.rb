class BillingService
  def self.generate_monthly_summary(client, month = Date.current.beginning_of_month)
    transactions = client.transactions
      .where(created_at: month.beginning_of_month..month.end_of_month)

    total_charges = transactions.sum(:charged_amount)
    total_credits_used = transactions.sum(:credits_used)

    service_breakdown = transactions.group(:service_type)
      .select('service_type,
               COUNT(*) as count,
               SUM(charged_amount) as total_amount,
               SUM(credits_used) as total_credits')
      .map(&:attributes)

    {
      client_name: client.name,
      period: month.strftime("%B %Y"),
      total_transactions: transactions.count,
      total_charges: total_charges,
      total_credits_used: total_credits_used,
      remaining_credits: client.current_balance,
      service_breakdown: service_breakdown
    }
  end
end
