module RageFlip
  class TextSubstitution
    SUBSTITUTIONS = {
      "bugeyes" => "(⊙_◎)",
      "cmd-" => "⌘-",
      "cmd" => "⌘",
      "cntl" => "⌃",
      "disapproval" => "ಠ_ಠ",
      "dogshrug" => '¯\_🐶_/¯',
      "duck-flip" => "(╯°□°)╯︵ ┻(duckflip)┻",
      "facepalm" => "(－‸ლ)",
      "flip" => "(╯°□°)╯︵ ┻━┻",
      "fu" => "t(-__-t)",
      "heresatable" => "┬─┬﻿ ノ( ゜-゜ノ)",
      "javaflip" => "(╯°□°)╯︵ ┻ɐʌɐɾ┻",
      "kungfuhamster" => '    ()__()
    / o o\   ;
   |\'=Y=\';-/
   { \  / }
    mmm mmm   ',
      "noevil" => "🙈🙉🙊",
      "omw" => "On my way!",
      "optn" => "⌥",
      "rage" => "ಠ益ಠ",
      "rageflip" => "(ノಠ益ಠ)ノ彡┻━┻",
      "rock" => '\m/ (>_<) \m/',
      "shft" => "⇧",
      "shift" => "⇧",
      "shrug" => '¯\_(ツ)_/¯',
      "shrugtable" => '┻━┻ ︵﻿ ¯\(ツ)/¯ ︵ ┻━┻',
      "unsee" => "♨_♨",
      "yuno" => "ლ(ಠ益ಠლ)"
    }.freeze

    def self.process(substitution_name)
      substitution_name = substitution_name.downcase

      if SUBSTITUTIONS.key?(substitution_name)
        SUBSTITUTIONS[substitution_name]
      end
    end

    def self.list_substitutions
      output = ["Available text substitutions:"]
      SUBSTITUTIONS.each do |name, text|
        # Truncate long substitutions for display
        display_text = (text.length > 50) ? "#{text[0..47]}..." : text
        output << "  #{name.ljust(15)} - #{display_text}"
      end
      output.join("\n")
    end

    def self.substitution_exists?(name)
      SUBSTITUTIONS.key?(name.downcase)
    end

    def self.substitution_names
      SUBSTITUTIONS.keys
    end
  end
end
