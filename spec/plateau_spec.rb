require 'rspec/autorun'
require_relative '../plateau.rb'

describe Plateau do
  subject { Plateau.new(4, 6) }

  describe '#can_move_to?' do
    context 'when upper-right spot' do
      spot = Tuple.new(4, 6)
      
      it { expect(subject.can_move_to?(spot)).to be_truthy }
    end

    context 'when bottom-left spot' do
      spot = Tuple.new(0, 0)

      it { expect(subject.can_move_to?(spot)).to be_truthy }
    end

    context 'when random valid spot' do
      spot = Tuple.new(rand(0..4), rand(0..6))

      it { expect(subject.can_move_to?(spot)).to be_truthy }
    end

    context 'when beyond top border' do
      spot = Tuple.new(2, 8)

      it { expect(subject.can_move_to?(spot)).to be_falsey }
    end

    context 'when beyond bottom border' do
      spot = Tuple.new(2, -2)

      it { expect(subject.can_move_to?(spot)).to be_falsey }
    end

    context 'when beyond left border' do
      spot = Tuple.new(-2, 4)

      it { expect(subject.can_move_to?(spot)).to be_falsey }
    end

    context 'when beyond right border' do
      spot = Tuple.new(6, 4)

      it { expect(subject.can_move_to?(spot)).to be_falsey }
    end
  end

  describe '#lock' do
    spot = Tuple.new(2, 4)

    it { expect { subject.lock(spot) }.to change { subject.can_move_to?(spot) }.from(true).to(false) }
  end
end

