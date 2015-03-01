class RewardsService
  attr :eligibility_service

  def initialize(eligibility_service)
    @eligibility_service = eligibility_service
  end

  def call(account_number, subscriptions)
    begin
      if eligibility_service.call(account_number)
        rewards = [ :zona ]
      end
    rescue EligibilityService::InvalidAccountNumber
      error_message = "Invalid account number."
    rescue Exception
    ensure
      rewards ||= []
      error_message ||= false
    end

    map_response(rewards, error_message)
  end

  private

  def map_response(rewards, error_message)
    {
      rewards: rewards || [],
      error:   error_message
    }
  end
end
