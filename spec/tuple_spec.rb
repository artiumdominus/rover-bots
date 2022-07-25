require 'rspec/autorun'
require_relative '../tuple.rb'

describe Tuple do
  describe '#to_a' do
    subject { Tuple.new(3, 4) }
    
    it { expect(subject.to_a).to eq([3, 4]) }
  end
  
  describe '#+' do
    a = Tuple.new(5, 1)
    b = Tuple.new(2, -7)
    
    it { expect(a + b).to eq(Tuple.new(7, -6)) }
  end

  context 'bad instantiation' do
    it { expect { Tuple.new('a', 6) }.to raise_error(ArgumentError) }
  end
end

