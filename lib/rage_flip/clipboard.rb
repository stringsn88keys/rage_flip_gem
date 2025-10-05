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
        # Windows requires UTF-16LE encoding for clip command to handle Unicode properly
        require 'tempfile'
        
        Tempfile.create(['clipboard', '.txt'], binmode: true) do |temp_file|
          # Convert text to UTF-16LE with BOM for Windows clipboard
          utf16_text = "\uFEFF#{text}".encode('UTF-16LE')
          temp_file.write(utf16_text)
          temp_file.flush
          system("clip < \"#{temp_file.path}\"")
        end
      else
        puts "Error: Unsupported platform for clipboard operations."
        return false
      end
      true
    end
  end
end
