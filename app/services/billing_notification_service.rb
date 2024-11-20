class BillingNotificationService

  FINANCE_EMAIL = 'finance@tosh.co.za'

  def self.send_monthly_invoice(client)
    summary = BillingService.generate_monthly_summary(client)

    BillingMailer.monthly_invoice(client, summary, FINANCE_EMAIL).deliver_now
  end

  def self.send_usage_alerts
    Client.find_each do |client|
      if low_credit_warning?(client)
        send_low_credit_alert(client)
      end
    end
  end

  private

  def self.send_low_credit_alert(client)
    BillingMailer.low_credit_alert(client, FINANCE_EMAIL).deliver_now
    AdminNotificationService.notify_low_credits(client)
  end
end
end
