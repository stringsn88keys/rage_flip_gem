module RageFlip
  class Strikethrough
    STRIKETHROUGH_CHAR = "\u0336"

    def self.process(text)
      text.each_char.map { |c| [c, STRIKETHROUGH_CHAR] }.join
    end
  end
end
