module RageFlip
  class Italic
    # Unicode leaves holes in these alphabets for letters that were already
    # encoded in the Letterlike Symbols block, so those are mapped explicitly.
    SLANTED_EXCEPTIONS = {
      "h" => "ℎ"
    }.freeze

    SCRIPT_EXCEPTIONS = {
      "B" => "ℬ",
      "E" => "ℰ",
      "F" => "ℱ",
      "H" => "ℋ",
      "I" => "ℐ",
      "L" => "ℒ",
      "M" => "ℳ",
      "R" => "ℛ",
      "e" => "ℯ",
      "g" => "ℊ",
      "o" => "ℴ"
    }.freeze

    def self.build_map(upper_start, lower_start, exceptions)
      upper = ("A".."Z").each_with_index.to_h { |c, i| [c, [upper_start + i].pack("U")] }
      lower = ("a".."z").each_with_index.to_h { |c, i| [c, [lower_start + i].pack("U")] }
      upper.merge(lower).merge(exceptions).freeze
    end
    private_class_method :build_map

    # Mathematical Italic
    SLANTED_MAP = build_map(0x1D434, 0x1D44E, SLANTED_EXCEPTIONS)
    # Mathematical Script
    SCRIPT_MAP = build_map(0x1D49C, 0x1D4B6, SCRIPT_EXCEPTIONS)

    # Characters without an alternative (digits, punctuation, accented
    # letters) pass through unchanged.
    def self.process(text, script: false)
      text.gsub(/[A-Za-z]/, script ? SCRIPT_MAP : SLANTED_MAP)
    end

    def self.slanted(text)
      process(text, script: false)
    end

    def self.script(text)
      process(text, script: true)
    end
  end
end
