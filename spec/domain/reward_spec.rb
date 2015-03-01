require_relative '../spec_helper.rb'

RSpec.describe Reward do
  let(:name) { :REWARD_NAME }

  subject { described_class.new(name) }

  describe '.new' do
    it 'assigns name' do
      expect(subject.name).to eq(name)
    end
  end

  describe '#<=>' do
    context 'when names match' do
      it 'rewards are equal' do
        expect(subject).to eq(described_class.new(name))
      end
    end

    context 'when names do not match' do
      let(:other_name) { :ANOTHER_REWARD }

      it 'rewards are equal' do
        expect(subject).not_to eq(described_class.new(other_name))
      end
    end
  end
end

