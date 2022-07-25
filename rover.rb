require './tuple.rb'
require './orientations.rb'

class Rover
  def initialize(x, y, orientation)
    @position = Tuple.new(x, y)
    @orientation = Orientations::BY_KEY[orientation]
    
    raise ArgumentError unless @orientation
  end
  
  attr_accessor :plateau
  attr_reader :position, :orientation
  
  def move
    next_position = position + orientation
    
    if plateau.can_move_to?(next_position)
      @position = next_position
    end
  end
  
  def turn_right
    @orientation = orientation.right_90_degrees
  end
  
  def turn_left
    @orientation = orientation.left_90_degrees
  end
  
  def x = position.x  
  def y = position.y
end
