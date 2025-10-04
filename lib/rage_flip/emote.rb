module RageFlip
  class Emote
    EMOTES = {
      "disapproval" => "(ಠ_ಠ)",
      "bullshit" => "🐄💩",
      "catshit" => "🐱💩",
      "dogshit" => "🐶💩",
      "pandashit" => "🐼💩",
      "horseshit" => "🐴💩",
      "koalashit" => "🐨💩",
      "batshit" => "🦇💩",
      "bugeyes" => "(⊙_◎)",
      "cmd-" => "⌘-",
      "cmd" => "⌘",
      "command" => "⌘",
      "cntl" => "⌃",
      "dogshrug" => '¯\_🐶_/¯',
      "facepalm" => "(－‸ლ)",
      "flip" => "(╯°□°)╯︵ ┻━┻",
      "fu" => "t(-__-t)",
      "heresatable" => "┬─┬ ノ( ゜-゜ノ)",
      "javaflip" => "(╯°□°)╯︵ ┻ɐʌɐɾ┻",
      "kungfuhamster" => "    ()__()\n    / o o\\   ;\n   |'=Y=';-/\n   { \\  / }\n    mmm mmm   ",
      "noevil" => "🙈🙉🙊",
      "omw" => "On my way!",
      "optn" => "⌥",
      "option" => "⌥",
      "rage" => "ಠ益ಠ",
      "rageflip" => "(ノಠ益ಠ)ノ彡┻━┻",
      "rock" => '\m/ (>_<) \m/',
      "shft" => "⇧",
      "shift" => "⇧",
      "shrug" => '¯\_(ツ)_/¯',
      "shrugtable" => '┻━┻ ︵ ¯\(ツ)/¯ ︵ ┻━┻',
      "unsee" => "♨_♨",
      "yuno" => "ლ(ಠ益ಠლ)"
    }.freeze

    def self.process(emote_name)
      emote_name = emote_name.downcase

      if EMOTES.key?(emote_name)
        EMOTES[emote_name]
      end
    end

    def self.list_emotes
      output = ["Available emotes:"]
      # Sort emotes by name for better organization
      sorted_emotes = EMOTES.sort_by { |name, _| name }

      # Calculate max name length for better alignment
      max_name_length = sorted_emotes.map { |name, _| name.length }.max

      sorted_emotes.each do |name, emote|
        output << "  #{name.ljust(max_name_length + 2)} - #{emote}"
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
