module RageFlip
  class Frustrated
    def self.process(text)
      text.split.map(&:upcase).join(". ") + "."
    end
  end
end
