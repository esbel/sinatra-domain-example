require_relative '../spec_helper.rb'

RSpec.describe 'RewardsService' do
  include Rack::Test::Methods

  def app
    App
  end

  describe '/' do
    it "returns 200" do
      get '/'

      expect(last_response).to be_ok
    end
  end
end
