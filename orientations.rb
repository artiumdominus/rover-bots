require './tuple.rb'

module Orientations
  class Orientation < Tuple
    def initialize(x, y, key)
      super(x, y)
      @key = key
    end
    
    attr_reader :key
    attr_accessor :right_90_degrees, :left_90_degrees
    
    def to_s
      key
    end
  end
  
  North = Orientation.new(0, +1, 'N')
  South = Orientation.new(0, -1, 'S')
  East  = Orientation.new(+1, 0, 'E')
  West  = Orientation.new(-1, 0, 'W')
  
  ALL = [North, East, South, West].freeze
  
  ALL.each_with_index do |o, i|
    o.right_90_degrees = ALL[(i+1) % ALL.count]
    o.left_90_degrees = ALL[(i-1) % ALL.count]
    o.freeze
  end
  
  BY_KEY = ALL.to_h { |o| [o.key, o] }
end

