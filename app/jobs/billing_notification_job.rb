class BillingNotificationJob < ApplicationJob
  queue_as :default

  def perform(client_id)
    client = Client.find(client_id)
    BillingNotificationService.send_monthly_invoice(client)
  end
end
