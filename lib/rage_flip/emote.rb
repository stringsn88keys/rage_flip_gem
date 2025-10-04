module RageFlip
  class Emote
    EMOTES = {
      'disapproval' => '(ಠ_ಠ)',
      'bullshit' => '🐄💩',
      'catshit' => '🐱💩', 
      'dogshit' => '🐶💩',
      'pandashit' => '🐼💩',
      'horseshit' => '🐴💩',
      'batshit' => '🦇💩'
    }.freeze
    
    def self.process(emote_name)
      emote_name = emote_name.downcase
      
      if EMOTES.key?(emote_name)
        EMOTES[emote_name]
      else
        nil
      end
    end
    
    def self.list_emotes
      output = ["Available emotes:"]
      EMOTES.each do |name, emote|
        output << "  #{name.ljust(12)} - #{emote}"
      end
      output.join("\n")
    end
    
    def self.emote_exists?(name)
      EMOTES.key?(name.downcase)
    end
    
    def self.emote_names
      EMOTES.keys
    end
  end
end