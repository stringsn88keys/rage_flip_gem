module RageFlip
  class Underline
    UNDERLINE_CHAR = "\u0332"
    DOUBLE_UNDERLINE_CHAR = "\u0333"
    
    def self.process(text, double: false)
      underline_char = double ? DOUBLE_UNDERLINE_CHAR : UNDERLINE_CHAR
      text.each_char.map { |c| [c, underline_char] }.flatten.join
    end
    
    def self.single_underline(text)
      process(text, double: false)
    end
    
    def self.double_underline(text)
      process(text, double: true)
    end
  end
end