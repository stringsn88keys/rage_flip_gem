module RageFlip
  class Chaos
    DEFAULT_CHAOS_LEVEL = 10
    
    def self.process(text, chaos_level = nil)
      chaos_level ||= ENV['CHAOS_LEVEL']&.to_i || DEFAULT_CHAOS_LEVEL
      
      text.each_char.map do |c|
        combining_chars = rand(1..chaos_level).times.map do
          "%c" % rand(0x300..0x36f)
        end
        [c, combining_chars]
      end.flatten.join
    end
    
    def self.set_chaos_level(instruction)
      current_level = ENV['CHAOS_LEVEL']&.to_i || DEFAULT_CHAOS_LEVEL
      
      case instruction
      when 'more'
        ENV['CHAOS_LEVEL'] = (current_level + 1).to_s
      when 'less'
        ENV['CHAOS_LEVEL'] = (current_level - 1).to_s
      else
        ENV['CHAOS_LEVEL'] = instruction.to_s
      end
      
      "chaos level is now #{ENV['CHAOS_LEVEL']}"
    end
  end
end