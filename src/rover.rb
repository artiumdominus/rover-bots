require_relative './tuple.rb'
require_relative './orientations.rb'

class Rover
  def initialize(x, y, orientation)
    @position = Tuple.new(x, y)
    @orientation = Orientations::BY_KEY[orientation]
    
    raise ArgumentError unless @orientation
  end
  
  attr_reader :position, :orientation, :plateau

  def land(plateau)
    @plateau = plateau
  end
  
  def move
    raise NotLandedError unless plateau

    next_position = position + orientation
    
    if plateau.can_move_to?(next_position)
      @position = next_position
    end
  end
  
  def turn_right
    rase NotLandedError unless plateau

    @orientation = orientation.right_90_degrees
  end
  
  def turn_left
    raise NotLandedError unless plateau

    @orientation = orientation.left_90_degrees
  end
  
  def x = position.x  
  def y = position.y

  class NotLandedError < Exception; end
end
