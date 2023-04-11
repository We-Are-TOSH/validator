class CheckCreditsController < ApplicationController
  require 'check_credits_service'

  def check
    credits_count = CheckCreditsService.get_credits_count

    if credits_count < 200
      CheckCreditsMailer.low_credits_email.deliver_now
    end
  end
end
