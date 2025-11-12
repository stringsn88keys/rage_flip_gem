require 'json'
require 'yaml'
require 'fileutils'

module RageFlip
  class Emote
    EMOTES = {
      "disapproval" => "(ಠ_ಠ)",
      "bullshit" => "🐄💩",
      "catshit" => "🐱💩",
      "dogshit" => "🐶💩",
      "pandashit" => "🐼💩",
      "popcorn" => "🍿",
      "horseshit" => "🐴💩",
      "koalashit" => "🐨💩",
      "batshit" => "🦇💩",
      "shboatload" => "💩🚢",
      "bugeyes" => "(⊙_◎)",
      "cmd-" => "⌘-",
      "cmd" => "⌘",
      "command" => "⌘",
      "deer" => "🦌",
      "cntl" => "⌃",
      "dogshrug" => '¯\_🐶_/¯',
      "facepalm" => "(－‸ლ)",
      "flip" => "(╯°□°)╯︵ ┻━┻",
      "fu" => "t(-__-t)",
      "heresatable" => "┬─┬ ノ( ゜-゜ノ)",
      "javaflip" => "(╯°□°)╯︵ ┻ɐʌɐɾ┻",
      "kungfuhamster" => "    ()__()\n    / o o\\   ;\n   |'=Y=';-/\n   { \\  / }\n    mmm mmm   ",
      "middlefinger" => "🖕",
      "noevil" => "🙈🙉🙊",
      "omg" => "😱",
      "omgcat" => "🙀",
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

    CONFIG_DIR = File.expand_path("~/.config/rage_flip")
    JSON_CONFIG_FILE = File.join(CONFIG_DIR, "emote.json")
    YAML_CONFIG_FILE = File.join(CONFIG_DIR, "emote.yml")

    def self.custom_config_path
      return JSON_CONFIG_FILE if File.exist?(JSON_CONFIG_FILE)
      return YAML_CONFIG_FILE if File.exist?(YAML_CONFIG_FILE)
      nil
    end

    def self.load_custom_emotes
      config_path = custom_config_path
      return {} unless config_path

      begin
        content = File.read(config_path)
        case File.extname(config_path)
        when '.json'
          JSON.parse(content)
        when '.yml', '.yaml'
          YAML.safe_load(content) || {}
        else
          {}
        end
      rescue => e
        puts "Warning: Failed to load custom emotes from #{config_path}: #{e.message}"
        {}
      end
    end

    def self.all_emotes
      @all_emotes ||= EMOTES.merge(load_custom_emotes)
    end

    def self.refresh_emotes
      @all_emotes = nil
      @emoji_only_emotes = nil
    end

    # Check if an emote value contains only emoji (no ASCII art or text)
    def self.emoji_only?(value)
      # Remove all emoji and see if anything is left (besides spaces)
      # This regex matches emoji characters
      value.gsub(/[\p{Emoji}\p{Emoji_Presentation}\p{Emoji_Modifier}\p{Emoji_Component}]/, '').strip.empty?
    end

    # Get all emoji-only emotes
    def self.emoji_only_emotes
      @emoji_only_emotes ||= all_emotes.select { |name, value| emoji_only?(value) }
    end

    # Try to split a compound emote name into parts
    # Returns an array of emote values if successful, nil otherwise
    def self.split_compound_emote(compound_name)
      # First try splitting by hyphen
      if compound_name.include?('-')
        parts = compound_name.split('-')
        results = parts.map { |part| all_emotes[part] }
        return results if results.all? && results.all? { |r| emoji_only?(r) }
      end

      # Try to find a combination of emoji-only emotes without separator
      # Use dynamic programming to find valid splits
      return find_emote_combination(compound_name)
    end

    # Find a valid combination of emoji-only emotes that match the compound name
    def self.find_emote_combination(name, start = 0, memo = {})
      return [] if start >= name.length
      return memo[[name, start]] if memo.key?([name, start])

      # Try each emoji-only emote starting at this position
      emoji_only_emotes.each do |emote_name, emote_value|
        next unless name[start..-1].start_with?(emote_name)

        rest_start = start + emote_name.length
        if rest_start >= name.length
          # We've matched the entire string
          memo[[name, start]] = [emote_value]
          return [emote_value]
        end

        # Try to match the rest
        rest = find_emote_combination(name, rest_start, memo)
        if rest
          result = [emote_value] + rest
          memo[[name, start]] = result
          return result
        end
      end

      memo[[name, start]] = nil
      nil
    end

    def self.process(emote_name)
      emote_name = emote_name.downcase

      # First check if it exists as-is
      if all_emotes.key?(emote_name)
        return all_emotes[emote_name]
      end

      # Try to split as compound emote
      compound_result = split_compound_emote(emote_name)
      return compound_result.join('') if compound_result

      nil
    end

    def self.list_emotes
      output = ["Available emotes:"]
      # Sort emotes by name for better organization
      sorted_emotes = all_emotes.sort_by { |name, _| name }

      # Calculate max name length for better alignment
      max_name_length = sorted_emotes.map { |name, _| name.length }.max

      sorted_emotes.each do |name, emote|
        output << "  #{name.ljust(max_name_length + 2)} - #{emote}"
      end
      output.join("\n")
    end

    def self.list_custom_emotes
      custom_emotes = load_custom_emotes

      if custom_emotes.empty?
        return "No custom emotes found. Use 'emote init-custom' to create a custom emote config file."
      end

      output = ["Custom emotes:"]
      # Sort emotes by name for better organization
      sorted_emotes = custom_emotes.sort_by { |name, _| name }

      # Calculate max name length for better alignment
      max_name_length = sorted_emotes.map { |name, _| name.length }.max

      sorted_emotes.each do |name, emote|
        output << "  #{name.ljust(max_name_length + 2)} - #{emote}"
      end

      config_path = custom_config_path
      if config_path
        output << ""
        output << "Config file: #{config_path}"
      end

      output.join("\n")
    end

    def self.init_custom_config
      FileUtils.mkdir_p(CONFIG_DIR) unless Dir.exist?(CONFIG_DIR)

      if File.exist?(JSON_CONFIG_FILE) || File.exist?(YAML_CONFIG_FILE)
        existing_file = File.exist?(JSON_CONFIG_FILE) ? JSON_CONFIG_FILE : YAML_CONFIG_FILE
        return "Custom emote config already exists: #{existing_file}"
      end

      # Create a sample JSON config file
      sample_config = {
        "example" => "This is an example custom emote",
        "heart" => "❤️",
        "wave" => "👋"
      }

      File.write(JSON_CONFIG_FILE, JSON.pretty_generate(sample_config))
      refresh_emotes

      "Custom emote config initialized: #{JSON_CONFIG_FILE}\n" +
      "Edit this file to add your custom emotes, then use 'emote list-custom' to see them."
    end

    def self.emote_exists?(name)
      all_emotes.key?(name.downcase)
    end

    def self.emote_names
      all_emotes.keys
    end
  end
end
