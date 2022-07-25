require 'rspec/autorun'
require_relative '../rover.rb'

describe Rover do
  let(:plateau) { Plateau.new(4, 4) }
  subject { Rover.new(2, 2, 'N') }

  before { subject.plateau = plateau }

  describe '#turn_right' do
    it { expect { subject.turn_right }.to change { subject.x }.by(0) }
    it { expect { subject.turn_right }.to change { subject.y }.by(0) }

    context 'when done once' do
      before { subject.turn_right }

      it { expect(subject.orientation.to_s).to eq('E') }
    end

    context 'when done twice' do
      before { 2.times { subject.turn_right } }

      it { expect(subject.orientation.to_s).to eq('S') }
    end

    context 'when done three times' do
      before { 3.times { subject.turn_right } }

      it { expect(subject.orientation.to_s).to eq('W') }
    end
  end

  describe '#turn_left' do
    it { expect { subject.turn_right }.to change { subject.x }.by(0) }
    it { expect { subject.turn_right }.to change { subject.y }.by(0) }

    context 'when done once' do
      before { subject.turn_left }

      it { expect(subject.orientation.to_s).to eq('W') }
    end

    context 'when done twice' do
      before { 2.times { subject.turn_left } }

      it { expect(subject.orientation.to_s).to eq('S') }
    end

    context 'when done three times' do
      before { 3.times { subject.turn_left } }

      it { expect(subject.orientation.to_s).to eq('E') }
    end
  end

  describe '#move' do
    context 'when heading north' do
      it { expect { subject.move }.to change { subject.y }.by(1) }

      context 'when move until plateau border' do
        it { expect { 5.times { subject.move } }.to change { subject.y }.by(2) }
      end
  
      context 'when blocked spot ahead' do
        before { plateau.lock(Tuple.new(2, 3)) }

        it { expect { subject.move }.to change { subject.y }.by(0) }
      end
    end

    context 'when heading east' do
      before { subject.turn_right }

      it { expect { subject.move }.to change { subject.x }.by(1) }
    end

    context 'when heading south' do
      before { 2.times { subject.turn_right } }

      it { expect { subject.move }.to change { subject.y }.by(-1) }
    end

    context 'when heading west' do
      before { subject.turn_left }

      it { expect { subject.move }.to change { subject.x }.by(-1) }
    end
  end

  context 'bad instantiation' do
    it { expect { Rover.new(1, 2, 'X') }.to raise_error(ArgumentError) }
  end
end
