require 'sinatra'
require 'sinatra/reloader' if development?

require_relative 'domain/channel'
require_relative 'domain/reward'
require_relative 'service_objects/eligibility_service'
require_relative 'service_objects/rewards_service'

class App < Sinatra::Base
  register Sinatra::Reloader if development?

  set :server, :puma

  get '/' do
    'Hello world!'
  end
end
