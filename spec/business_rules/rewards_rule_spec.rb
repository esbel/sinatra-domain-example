require_relative '../spec_helper.rb'

RSpec.describe RewardsRule do
  subject { described_class.new }

  describe '#call' do
    context 'when channel set is empty' do
      let(:channels) { [] }

      it 'returns an empty collection' do
        expect(subject.call(channels)).to be_empty
      end
    end

    context 'when channel set is not empty' do
      let(:channels) { [ channel ] }

      shared_examples_for 'channel into reward mapping' do |channel, rewards|
        it 'maps into rewards' do
          channels = [ Channel.new(channel) ]

          expect(subject.call(channels)).to eq(rewards)
        end
      end

      it_behaves_like 'channel into reward mapping', :KIDS,   []
      it_behaves_like 'channel into reward mapping', :NEWS,   []
      it_behaves_like 'channel into reward mapping', :MOVIES, [ Reward.new(:PIRATES_OF_THE_CARIBBEAN_COLLECTION) ]
      it_behaves_like 'channel into reward mapping', :MUSIC,  [ Reward.new(:KARAOKE_PRO_MICROPHONE) ]
      it_behaves_like 'channel into reward mapping', :SPORTS, [ Reward.new(:CHAMPIONS_LEAGUE_FINAL_TICKET) ]

      context 'when multiple qualifying channels provided' do
        let(:channels) { [ Channel.new(:SPORTS), Channel.new(:MUSIC) ] }

        it 'returns multiple rewards' do
          expect(subject.call(channels).length).to eq(2)
        end
      end
    end
  end
end
