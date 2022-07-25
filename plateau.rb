require './tuple.rb'
require 'set'

class Plateau
  def initialize(right, top)
    @upper_right = Tuple.new(right, top)
    @locked = Set.new
  end
  
  attr_reader :upper_right
  
  def can_move_to?(position)
    x = position.x
    y = position.y
  
    (x >= 0) and (x <= upper_right.x) and
      (y >= 0) and (y <= upper_right.y) and not locked?(x, y)
  end
  
  def lock(position) = @locked << position.to_a
  
  private
  
    def locked?(x, y) = @locked.include? [x, y]
end

