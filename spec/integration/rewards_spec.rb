require_relative '../spec_helper.rb'

RSpec.describe 'RewardsService' do
  describe '/' do
    it 'returns 200' do
      get '/'

      expect(last_response).to be_ok
    end
  end
end
