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
      "middlefinger" => "🖕",
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
    end

    def self.process(emote_name)
      emote_name = emote_name.downcase

      if all_emotes.key?(emote_name)
        all_emotes[emote_name]
      end
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
