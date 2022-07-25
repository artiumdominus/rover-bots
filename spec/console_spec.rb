require 'rspec/autorun'
require_relative '../src/console.rb'
require 'stringio'

describe Console do
  let(:file) do
    StringIO.new <<-FILE_CONTENT
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM

    FILE_CONTENT
  end

  let(:expected_output) do
    <<-EXPECTED_OUTPUT
1 3 N
5 1 E
    EXPECTED_OUTPUT
  end

  describe "#execute" do
    subject { Console::execute }

    it "calculates the position of each rover" do
      allow(File).to receive(:open).and_return(file)

      output = ""
      
      allow(Console).to receive(:print)
      allow(Console).to receive(:puts) { |text| output << "#{text}\n" }
      allow(Console).to receive(:readline).and_return("input.data")

      subject

      expect(output).to eq(expected_output)
    end
  end
end