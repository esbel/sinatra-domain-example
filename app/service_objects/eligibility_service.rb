class EligibilityService
  class InvalidAccountNumber < Exception; end

  def call(account_number)
    account_number == "CATCH22"
  end
end
