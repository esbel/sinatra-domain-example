require_relative '../spec_helper.rb'

RSpec.describe Reward do
  let(:name) { double }

  subject { described_class.new(name) }

  describe '.new' do
    it 'assigns name' do
      expect(subject.name).to eq(name)
    end
  end
end

