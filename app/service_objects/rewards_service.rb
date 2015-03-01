class RewardsService
  attr :eligibility_service, :rewards_rule

  def initialize(eligibility_service)
    @eligibility_service = eligibility_service

    @rewards_rule = RewardsRule.new
  end

  def call(account_number, subscriptions)
    begin
      if eligibility_service.call(account_number)
        rewards = rewards_rule.call(subscriptions)
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
      rewards: rewards.collect(&:name) || [],
      error:   error_message
    }
  end
end
