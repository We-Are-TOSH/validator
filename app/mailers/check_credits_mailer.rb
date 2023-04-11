class CheckCreditsMailer < ApplicationMailer
  default to: -> { ENV['ADMIN_EMAIL'] }

  def low_credits_email
    @credits_count = CheckCreditsService.get_credits_count
    mail(subject: "VerifyID Credits Low")
  end
end