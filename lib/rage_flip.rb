require_relative "rage_flip/version"
require_relative "rage_flip/flipper"
require_relative "rage_flip/sarcasm"
require_relative "rage_flip/strikethrough"
require_relative "rage_flip/underline"
require_relative "rage_flip/chaos"
require_relative "rage_flip/clipboard"
require_relative "rage_flip/emote"
require_relative "rage_flip/text_substitution"
require "shellwords"

module RageFlip
  class Error < StandardError; end
end
