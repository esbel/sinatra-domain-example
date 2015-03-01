ENV['RACK_ENV'] = 'test'

require_relative '../app/app.rb'
require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  def app
    App
  end
end
