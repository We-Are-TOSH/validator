namespace :check_credits do
  desc "Check the credits and send an email if they are low"
  task :run => :environment do
    # Invoke the check action of CheckCreditsController
    CheckCreditsController.new.check

    # Send an email if credits are low
    credits_count = CheckCreditsService.get_credits_count
    if credits_count < 200
      CheckCreditsMailer.low_credits_email.deliver_now
    end
  end
end
