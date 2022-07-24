# Robot squad!

require 'set'

Limit = Struct.new(:x, :y)

class Tuple
  def initialize(x, y)
    @x = Integer(x)
    @y = Integer(y)
  end
  
  attr_reader :x, :y
  
  def +(other)
    Tuple.new(self.x + other.x, self.y + other.y)
  end
  
  def to_a
    [@x, @y]
  end
end

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
  
  def lock(position)
    @locked << position.to_a
  end
  
  private
  
    def locked?(x, y)
      @locked.include? [x, y]
    end
end

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
  
  def x
    position.x
  end
  
  def y
    position.y
  end
  
  class Executor
    COMMANDS = {
      'M' => :move,
      'L' => :turn_left,
      'R' => :turn_right
    }
    
    def self.call(rover, command_stream)    
      commands = command_stream.split("").map do |c|
        unless COMMANDS.keys.include? c
          raise ArgumentError
        end
        
        COMMANDS[c]
      end
      
      commands.each { |c| rover.send(c) }
    end
  end
end

module Main
  class WrongFormatFileError < Exception; end

  class << self
    def execute
      print "Insert the name of the input file: "
      file_name = readline.chomp

      begin
        f = File.open(file_name)
        
        plateau = read_plateau(f)

        read_rovers_info(f).map do |rover, commands|
          rover.plateau = plateau
          
          begin
            Rover::Executor.call(rover, commands)
          rescue ArgumentError
            raise WrongFormatFileError
          end
          
          puts "#{rover.x} #{rover.y} #{rover.orientation}"
          
          plateau.lock(rover.position)
        end
        
        f.close
      rescue Errno::ENOENT
        puts "File not found. Check if there's no type."
      rescue WrongFormatFileError
        puts "File in wrong format or corrupted."
      end
    end
    
    def read_plateau(f)
      f.readline.split(" ") => x, y
      Plateau.new(x, y)
    rescue ArgumentError, NoMatchingPatternError
      raise WrongFormatFileError
    end
    
    def read_rovers_info(f)
      rovers = []
    
      f.readlines.map(&:chomp).each_slice(2) do |position, commands|
        unless position.empty?
          position.split(" ") => x, y, orientation
          rover = Rover.new(x, y, orientation)
          
          rovers << [rover, commands]
        end
      end
      
      rovers
    rescue ArgumentError, NoMatchingPatternError
      raise WrongFormatFileError
    end
  end
end

Main::execute

