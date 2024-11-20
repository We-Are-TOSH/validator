class BillingMailer < ApplicationMailer
  def monthly_invoice(client, summary, to_email = nil)
    @client = client
    @summary = summary
    mail(
      to: to_email || client.billing_email,
      subject: "Monthly Invoice - #{summary[:period]}"
    )
  end

  def low_credit_alert(client, to_email = nil)
    @client = client
    @current_balance = client.current_balance
    mail(
      to: to_email || client.billing_email,
      subject: "Low Credit Balance Alert"
    )
  end
end
