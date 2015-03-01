require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'domain/channel'
require_relative 'domain/reward'
require_relative 'business_rules/rewards_rule'
require_relative 'service_objects/eligibility_service'
require_relative 'service_objects/rewards_service'

class App < Sinatra::Base
  register Sinatra::Reloader if development?

  set :server, :puma

  get '/' do
    'Rewards service: OK'
  end

  get '/rewards' do
    rewards_service = RewardsService.new(EligibilityService.new)
    subscriptions   = map_subscriptions(params["channel_subscriptions"])

    result = rewards_service.call(params["account_number"], subscriptions)

    result.to_json
  end

  private

  def map_subscriptions(channel_names)
    channel_names.map { |name| Channel.new(name) }
  end
end
