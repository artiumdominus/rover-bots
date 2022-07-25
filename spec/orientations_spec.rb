require 'rspec/autorun'
require_relative '../orientations.rb'

describe Orientations::North do
  subject { Orientations::North }

  describe '::to_s' do
    it { expect(subject::to_s).to eq('N') }
  end
  
  describe '::right_90_degrees' do
    it { expect(subject::right_90_degrees).to eq(Orientations::East) }
  end
  
  describe '::left_90_degrees' do
    it { expect(subject::left_90_degrees).to eq(Orientations::West) }
  end
end

describe Orientations::East do
  subject { Orientations::East }

  describe '::to_s' do
    it { expect(subject::to_s).to eq('E') }
  end
  
  describe '::right_90_degrees' do
    it { expect(subject::right_90_degrees).to eq(Orientations::South) }
  end
  
  describe '::left_90_degrees' do
    it { expect(subject::left_90_degrees).to eq(Orientations::North) }
  end
end

describe Orientations::South do
  subject { Orientations::South }

  describe '::to_s' do
    it { expect(subject::to_s).to eq('S') }
  end
  
  describe '::right_90_degrees' do
    it { expect(subject::right_90_degrees).to eq(Orientations::West) }
  end
  
  describe '::left_90_degrees' do
    it { expect(subject::left_90_degrees).to eq(Orientations::East) }
  end
end

describe Orientations::West do
  subject { Orientations::West }

  describe '::to_s' do
    it { expect(subject::to_s).to eq('W') }
  end
  
  describe '::right_90_degrees' do
    it { expect(subject::right_90_degrees).to eq(Orientations::North) }
  end
  
  describe '::left_90_degrees' do
    it { expect(subject::left_90_degrees).to eq(Orientations::South) }
  end
end

