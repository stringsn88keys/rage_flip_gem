require "spec_helper"

RSpec.describe RageFlip::Clipboard do
  describe ".copy" do
    it "handles basic ASCII text" do
      expect(RageFlip::Clipboard.copy("Hello World")).to be true
    end

    it "handles Unicode characters" do
      unicode_text = "(ノಠ益ಠ)ノ彡┻━┻"
      expect(RageFlip::Clipboard.copy(unicode_text)).to be true
    end

    it "handles emoji characters" do
      emoji_text = "🐄💩"
      expect(RageFlip::Clipboard.copy(emoji_text)).to be true
    end

    it "handles accented characters" do
      accented_text = "café résumé naïve"
      expect(RageFlip::Clipboard.copy(accented_text)).to be true
    end

    it "handles flipped text characters" do
      flipped_text = "ʇsǝʇ"
      expect(RageFlip::Clipboard.copy(flipped_text)).to be true
    end

    it "handles rage flip output" do
      rage_text = RageFlip::Flipper.rage_flip("test")
      expect(RageFlip::Clipboard.copy(rage_text)).to be true
    end

    it "returns true on successful copy" do
      expect(RageFlip::Clipboard.copy("simple test")).to be true
    end
  end
end