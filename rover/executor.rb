class Rover
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
