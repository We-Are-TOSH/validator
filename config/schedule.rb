every 8.hours do
  rake "check_credits"
end

every 1.day, at: '8:00 am' do
  runner "BillingNotificationService.send_usage_alerts"
end

every 1.month, at: 'start of the month at 12:01am' do
  runner "Client.find_each { |client| BillingNotificationJob.perform_later(client.id) }"
end
