module RageFlip
  class Clipboard
    def self.copy(text)
      case RUBY_PLATFORM
      when /darwin/
        system("echo #{text.shellescape} | pbcopy")
      when /linux/
        if system("which xclip > /dev/null 2>&1")
          system("echo #{text.shellescape} | xclip -selection clipboard")
        elsif system("which xsel > /dev/null 2>&1")
          system("echo #{text.shellescape} | xsel --clipboard --input")
        else
          puts "Error: No clipboard utility found. Please install xclip or xsel."
          return false
        end
      when /mswin|mingw|cygwin/
        system("echo #{text.shellescape} | clip")
      else
        puts "Error: Unsupported platform for clipboard operations."
        return false
      end
      true
    end
  end
end
