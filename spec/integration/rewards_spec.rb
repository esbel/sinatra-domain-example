require_relative '../spec_helper.rb'

RSpec.describe 'RewardsService' do
  describe '/' do
    it 'returns 200' do
      get '/'

      expect(last_response).to be_ok
    end
  end

  describe '/rewards' do
    let(:params) do
      {
        account_number: "CATCH22",
        channel_subscriptions: [ "KIDS", "SPORTS" ]
      }
    end

    it 'returns 200' do
      get '/rewards', params

      expect(last_response).to be_ok
    end

    it 'returns false as error in response body' do
      get '/rewards', params

      parsed_response = JSON.parse(last_response.body)

      expect(parsed_response["error"]).to eq(false)
    end

    it 'returns example reward' do
      get '/rewards', params

      parsed_response = JSON.parse(last_response.body)

      expect(parsed_response["rewards"]).
        to include("CHAMPIONS_LEAGUE_FINAL_TICKET")
    end
  end
end
