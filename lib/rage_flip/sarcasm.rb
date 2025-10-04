module RageFlip
  class Sarcasm
    def self.process(text)
      cycle_enum = [:upcase, :downcase].cycle
      text.each_char.map { |c| c.send(cycle_enum.next) }.join
    end
  end
end