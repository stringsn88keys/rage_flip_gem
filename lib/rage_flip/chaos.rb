module RageFlip
  class Chaos
    DEFAULT_CHAOS_LEVEL = 10
    CHAOS_LEVEL_FILE = File.expand_path("~/.chaos_level.txt")
    
    def self.process(text, chaos_level = nil)
      chaos_level ||= read_chaos_level
      
      text.each_char.map do |c|
        combining_chars = rand(1..chaos_level).times.map do
          "%c" % rand(0x300..0x36f)
        end
        [c, combining_chars]
      end.flatten.join
    end
    
    def self.set_chaos_level(instruction)
      current_level = read_chaos_level
      
      case instruction
      when 'more'
        new_level = current_level + 1
      when 'less'
        new_level = [current_level - 1, 1].max # Don't go below 1
      else
        new_level = instruction.to_i
        if new_level <= 0
          return "Error: Chaos level must be a positive number"
        end
      end
      
      write_chaos_level(new_level)
      "chaos level is now #{new_level}"
    end
    
    def self.read_chaos_level
      if File.exist?(CHAOS_LEVEL_FILE)
        level = File.read(CHAOS_LEVEL_FILE).strip.to_i
        level > 0 ? level : DEFAULT_CHAOS_LEVEL
      else
        DEFAULT_CHAOS_LEVEL
      end
    end
    
    def self.write_chaos_level(level)
      File.write(CHAOS_LEVEL_FILE, level.to_s)
    end
    
    def self.current_chaos_level
      read_chaos_level
    end
  end
end