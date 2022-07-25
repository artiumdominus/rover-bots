# Robot squad!

require './plateau.rb'
require './rover.rb'
require './rover/executor.rb'

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
        puts "File not found. Check if there's no typo: #{file_name}"
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

