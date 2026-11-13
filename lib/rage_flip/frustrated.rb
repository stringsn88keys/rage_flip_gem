module RageFlip
  class Frustrated
    def self.process(text)
      Interrobang.process(text).split.map(&:upcase).join(". ") + "."
    end
  end
end
