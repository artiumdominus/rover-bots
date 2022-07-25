require 'rspec/autorun'
require_relative '../../src/plateau.rb'
require_relative '../../src/rover.rb'
require_relative '../../src/rover/executor.rb'

describe Rover::Executor do
  let(:plateau) { Plateau.new(8, 8) }
  let(:rover) { Rover.new(4, 4, 'N').tap { |r| r.land(plateau) } }

  subject { Rover::Executor::call(rover, command_stream) }

  describe "::call" do
    let(:command_stream) { 'LMMRMRMLMR' }

    it 'should translate commands and control rover' do
      expect(rover).to receive(:move).exactly(5).times
      expect(rover).to receive(:turn_right).exactly(3).times
      expect(rover).to receive(:turn_left).exactly(2).times

      subject
    end

    it 'should move the rover around' do
      expect { subject }.to change { rover.x }.from(4).to(3)
        .and change { rover.y }.from(4).to(6)
        .and change { rover.orientation.to_s }.from('N').to('E')
    end

    context 'when command_stream is corrupted' do
      let(:command_stream) { 'LMMRM RMLXMR' }

      it { expect { subject }.to raise_error(ArgumentError) }
    end    
  end
end
