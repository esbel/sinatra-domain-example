require_relative '../spec_helper.rb'

RSpec.describe RewardsService do
  let(:eligibility_service) { double(EligibilityService) }

  subject { described_class.new(eligibility_service) }

  describe '.new' do
    it 'assigns eligibility_service' do
      expect(subject.eligibility_service).to eq(eligibility_service)
    end

    it 'instantiates rewards_rule' do
      expect(subject.rewards_rule).to be_a_kind_of(RewardsRule)
    end
  end

  describe '.call' do
    let(:account_number)        { double }
    let(:channel_subscriptions) { double }
    let(:rewards)               { [] }

    before do
      allow(eligibility_service).
        to receive(:call).
        and_return(eligibility)
    end

    context 'when customer is eligible' do
      let(:channel_subscriptions) { [ Channel.new("MOVIES") ] }
      let(:eligibility) { true }

      it 'returns some rewards' do
        expect(subject.call(account_number, channel_subscriptions)[:rewards]).
          not_to be_empty
      end

      it 'calls RewardsRule to get rewards' do
        expect(subject.rewards_rule).
          to receive(:call).
          with(channel_subscriptions)

        subject.call(account_number, channel_subscriptions)
      end

      it 'returns mapped rewards' do
        expect(subject.call(account_number, channel_subscriptions)[:rewards]).
          to include("PIRATES_OF_THE_CARIBBEAN_COLLECTION")
      end
    end

    context 'when customer is ineligible' do
      let(:eligibility) { false }

      it 'returns no rewards' do
        expect(subject.call(account_number, channel_subscriptions)[:rewards]).
          to be_empty
      end
    end

    context 'an exception was raised' do
      let(:eligibility) { false }

      before do
        allow(eligibility_service).
          to receive(:call).
          and_raise(Exception)
      end

      it 'returns no rewards' do
        expect(subject.call(account_number, channel_subscriptions)[:rewards]).
          to be_empty
      end
    end

    context 'invalid account number exception was raised' do
      let(:eligibility) { false }

      before do
        allow(eligibility_service).
          to receive(:call).
          and_raise(EligibilityService::InvalidAccountNumber)
      end

      it 'returns no rewards' do
        expect(subject.call(account_number, channel_subscriptions)[:rewards]).
          to be_empty
      end

      it 'returns notifies about error' do
        expect(subject.call(account_number, channel_subscriptions)[:error]).
          to eq("Invalid account number.")
      end
    end
  end
end
