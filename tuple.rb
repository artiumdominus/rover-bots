class Tuple
  def initialize(x, y)
    @x = Integer(x)
    @y = Integer(y)
  end
  
  attr_reader :x, :y
  
  def +(other) = Tuple.new(self.x + other.x, self.y + other.y)
  def ==(other) = (self.x == other.x) && (self.y == other.y)
  
  def to_a = [@x, @y]
end

