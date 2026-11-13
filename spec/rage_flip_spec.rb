require "spec_helper"

RSpec.describe RageFlip do
  describe RageFlip::Flipper do
    describe ".flip" do
      it "flips text upside down" do
        result = RageFlip::Flipper.flip("Hello")
        expect(result).to eq("oʅʅǝH")
      end

      it "turns ? into ¿ and the interrobang into ⸘" do
        expect(RageFlip::Flipper.flip("why?")).to eq("¿ʎɥʍ")
        expect(RageFlip::Flipper.flip("‽")).to eq("⸘")
      end
    end

    describe ".rage_flip" do
      it "adds rage emoticons to flipped text" do
        result = RageFlip::Flipper.rage_flip("test")
        expect(result).to include("(ノಠ益ಠ)ノ彡┻")
        expect(result).to include("┻")
      end
    end

    describe ".table_flip" do
      it "adds table flip emoticons to flipped text" do
        result = RageFlip::Flipper.table_flip("test")
        expect(result).to include("(╯°□°)╯︵┻")
        expect(result).to include("┻")
        expect(result).to include("ʇsǝʇ") # flipped version of 'test'
      end
    end

    describe ".flip_text" do
      it "flips text without any emoticons" do
        result = RageFlip::Flipper.flip_text("test")
        expect(result).to eq("ʇsǝʇ")
        expect(result).not_to include("(")
        expect(result).not_to include("┻")
      end
    end
  end

  describe RageFlip::Interrobang do
    describe ".process" do
      it "replaces ?! and !? with an interrobang" do
        expect(RageFlip::Interrobang.process("what?! really!?")).to eq("what‽ really‽")
      end

      it "makes one interrobang per pair, left to right" do
        expect(RageFlip::Interrobang.process("?!?!")).to eq("‽‽")
        expect(RageFlip::Interrobang.process("?!?")).to eq("‽?")
        expect(RageFlip::Interrobang.process("!!?")).to eq("!‽")
        expect(RageFlip::Interrobang.process("!!??")).to eq("!‽?")
      end

      it "leaves repeated ? or ! alone" do
        expect(RageFlip::Interrobang.process("?? !!")).to eq("?? !!")
      end
    end

    it "is applied by every text transform" do
      expect(RageFlip::Flipper.flip_text("a?!")).to eq("⸘ɐ")
      expect(RageFlip::Flipper.rage_flip("?!")).to eq("(ノಠ益ಠ)ノ彡┻⸘┻")
      expect(RageFlip::Flipper.table_flip("!?")).to eq("(╯°□°)╯︵┻⸘ ┻")
      expect(RageFlip::Sarcasm.process("no?!")).to eq("No‽")
      expect(RageFlip::Frustrated.process("why?! no")).to eq("WHY‽. NO.")
      expect(RageFlip::Strikethrough.process("?!")).to eq("‽̶")
      expect(RageFlip::Underline.single_underline("?!")).to eq("‽̲")
      expect(RageFlip::Underline.double_underline("?!")).to eq("‽̳")
      expect(RageFlip::Italic.slanted("a?!")).to eq("𝑎‽")
      expect(RageFlip::Italic.script("a?!")).to eq("𝒶‽")
      expect(RageFlip::Confusable.process("?!")).to eq("‽")
      expect(RageFlip::Latex.process("x^2?!")).to eq("x²‽")
      expect(RageFlip::Chaos.process("?!", 1)).to start_with("‽")
    end
  end

  describe RageFlip::Sarcasm do
    describe ".process" do
      it "alternates case of characters" do
        result = RageFlip::Sarcasm.process("hello")
        expect(result).to eq("HeLlO")
      end
    end
  end

  describe RageFlip::Frustrated do
    describe ".process" do
      it "uppercases words and joins with periods" do
        result = RageFlip::Frustrated.process("one more day")
        expect(result).to eq("ONE. MORE. DAY.")
      end

      it "handles single word" do
        result = RageFlip::Frustrated.process("hello")
        expect(result).to eq("HELLO.")
      end

      it "handles multiple spaces" do
        result = RageFlip::Frustrated.process("why  is  this")
        expect(result).to eq("WHY. IS. THIS.")
      end
    end
  end

  describe RageFlip::Confusable do
    describe ".process" do
      it "replaces every letter with a different glyph" do
        input = ("a".."z").to_a.join + ("A".."Z").to_a.join
        result = RageFlip::Confusable.process(input)
        expect(result.each_char.count).to eq(input.length)
        result.each_char.zip(input.each_char).each do |out, orig|
          expect(out).not_to eq(orig)
          expect(RageFlip::Confusable::CONFUSABLES[orig]).to include(out)
        end
      end

      it "leaves non-letters untouched" do
        expect(RageFlip::Confusable.process("123 !!?")).to eq("123 !‽")
      end

      it "has confusables for every ASCII letter" do
        letters = ("a".."z").to_a + ("A".."Z").to_a
        expect(RageFlip::Confusable::CONFUSABLES.keys).to match_array(letters)
      end
    end
  end

  describe RageFlip::Strikethrough do
    describe ".process" do
      it "adds strikethrough characters" do
        result = RageFlip::Strikethrough.process("test")
        expect(result).to include("\u0336")
      end
    end
  end

  describe RageFlip::Underline do
    describe ".single_underline" do
      it "adds single underline characters" do
        result = RageFlip::Underline.single_underline("test")
        expect(result).to include("\u0332")
      end
    end

    describe ".double_underline" do
      it "adds double underline characters" do
        result = RageFlip::Underline.double_underline("test")
        expect(result).to include("\u0333")
      end
    end
  end

  describe RageFlip::Italic do
    describe ".slanted" do
      it "swaps letters for mathematical italic characters" do
        expect(RageFlip::Italic.slanted("Az")).to eq("\u{1D434}\u{1D467}")
      end

      it "uses the Letterlike Symbols character for h" do
        expect(RageFlip::Italic.slanted("h")).to eq("\u210E")
      end
    end

    describe ".script" do
      it "swaps letters for mathematical script characters" do
        expect(RageFlip::Italic.script("Az")).to eq("\u{1D49C}\u{1D4CF}")
      end

      it "uses the Letterlike Symbols characters for letters missing from the script block" do
        expect(RageFlip::Italic.script("BEFHILMRego")).to eq("\u212C\u2130\u2131\u210B\u2110\u2112\u2133\u211B\u212F\u210A\u2134")
      end
    end

    describe ".process" do
      it "maps every ASCII letter to a distinct, assigned character" do
        letters = [*"A".."Z", *"a".."z"]
        [false, true].each do |script|
          mapped = letters.map { |c| RageFlip::Italic.process(c, script: script) }
          expect(mapped.uniq.length).to eq(52)
          expect(mapped).to all(match(/\A\p{Assigned}\z/))
        end
      end

      it "leaves digits, punctuation, whitespace and accented letters unchanged" do
        expect(RageFlip::Italic.process("1 2, é!")).to eq("1 2, é!")
        expect(RageFlip::Italic.process("1 2, é!", script: true)).to eq("1 2, é!")
      end
    end
  end

  describe RageFlip::Latex do
    describe ".process" do
      def latex(text) = RageFlip::Latex.process(text)

      it "replaces symbol commands and keeps spacing as typed" do
        expect(latex("\\alpha + \\beta \\to \\Omega")).to eq("α + β → Ω")
        expect(latex("\\forall x \\in \\emptyset, x \\neq \\infty")).to eq("∀ x ∈ ∅, x ≠ ∞")
      end

      it "supports \\interrobang" do
        expect(latex("what\\interrobang")).to eq("what‽")
      end

      it "converts superscripts and subscripts" do
        expect(latex("\\int_0^1 x^2 dx")).to eq("∫₀¹ x² dx")
        expect(latex("x_{n+1} = x_n^2")).to eq("xₙ₊₁ = xₙ²")
        expect(latex("\\sum_{i=1}^{n} i^{-1}")).to eq("∑ᵢ₌₁ⁿ i⁻¹")
        expect(latex("H_2O and E = mc^2")).to eq("H₂O and E = mc²")
      end

      it "leaves scripts as typed when a character has no Unicode script form" do
        expect(latex("e^{i\\pi}")).to eq("e^{iπ}")
        expect(latex("x^{q}")).to eq("x^{q}")
        expect(latex("a^ b_")).to eq("a^ b_")
      end

      it "converts square and nth roots" do
        expect(latex("\\sqrt{x+1}")).to eq("√(x+1)")
        expect(latex("\\sqrt2 \\sqrt{x} \\sqrt\\pi")).to eq("√2 √x √π")
        expect(latex("\\sqrt[3]{8} \\sqrt[4]{x} \\sqrt[5]{y}")).to eq("∛8 ∜x ⁵√y")
        expect(latex("\\sqrt")).to eq("√")
      end

      it "converts fractions" do
        expect(latex("\\frac{1}{2} \\frac34")).to eq("½ ¾")
        expect(latex("\\frac{a+b}{c}")).to eq("(a+b)/c")
        expect(latex("\\frac{1}")).to eq("\\frac{1}")
      end

      it "handles escapes, unknown commands and unbalanced braces" do
        expect(latex("\\{x\\} 100\\% \\$5")).to eq("{x} 100% $5")
        expect(latex("\\unknown \\alphax")).to eq("\\unknown \\alphax")
        expect(latex("x^{2")).to eq("x^{2")
        expect(latex("\\left( x \\right)^2")).to eq("( x )²")
      end

      it "leaves plain text unchanged" do
        expect(latex("Hello World 123 é 👍🏽")).to eq("Hello World 123 é 👍🏽")
      end
    end
  end

  describe RageFlip::Chaos do
    let(:chaos_file) { File.expand_path("~/.chaos_level.txt") }

    before do
      # Clean up chaos file before each test
      File.delete(chaos_file) if File.exist?(chaos_file)
    end

    after do
      # Clean up chaos file after each test
      File.delete(chaos_file) if File.exist?(chaos_file)
    end

    describe ".process" do
      it "adds combining characters for chaos effect" do
        result = RageFlip::Chaos.process("test", 5)
        expect(result.length).to be > 4 # Should be longer than original
      end

      it "uses default chaos level when no file exists" do
        result = RageFlip::Chaos.process("test")
        expect(result.length).to be > 4 # Should be longer than original
      end
    end

    describe ".set_chaos_level" do
      it "sets chaos level to specific number" do
        result = RageFlip::Chaos.set_chaos_level("15")
        expect(File.read(chaos_file).strip).to eq("15")
        expect(result).to eq("chaos level is now 15")
      end

      it "increases chaos level with more" do
        RageFlip::Chaos.set_chaos_level("10")
        result = RageFlip::Chaos.set_chaos_level("more")
        expect(File.read(chaos_file).strip).to eq("11")
        expect(result).to eq("chaos level is now 11")
      end

      it "decreases chaos level with less" do
        RageFlip::Chaos.set_chaos_level("10")
        result = RageFlip::Chaos.set_chaos_level("less")
        expect(File.read(chaos_file).strip).to eq("9")
        expect(result).to eq("chaos level is now 9")
      end

      it "does not go below 1" do
        RageFlip::Chaos.set_chaos_level("1")
        result = RageFlip::Chaos.set_chaos_level("less")
        expect(File.read(chaos_file).strip).to eq("1")
        expect(result).to eq("chaos level is now 1")
      end
    end

    describe ".read_chaos_level" do
      it "returns default when file does not exist" do
        expect(RageFlip::Chaos.read_chaos_level).to eq(10)
      end

      it "reads level from file when it exists" do
        File.write(chaos_file, "25")
        expect(RageFlip::Chaos.read_chaos_level).to eq(25)
      end
    end
  end

  describe RageFlip::Emote do
    describe ".process" do
      it "returns correct emote for disapproval" do
        result = RageFlip::Emote.process("disapproval")
        expect(result).to eq("(ಠ_ಠ)")
      end

      it "returns the text interrobang for interrobangtext and keeps the emoji for interrobang" do
        expect(RageFlip::Emote.process("interrobangtext")).to eq("‽")
        expect(RageFlip::Emote.process("interrobang")).to eq("⁉️")
      end

      it "returns correct emote for bullshit" do
        result = RageFlip::Emote.process("bullshit")
        expect(result).to eq("🐄💩")
      end

      it "returns correct emote for dogshit" do
        result = RageFlip::Emote.process("dogshit")
        expect(result).to eq("🐶💩")
      end

      it "returns temperature unit symbols" do
        expect(RageFlip::Emote.process("celsius")).to eq("℃")
        expect(RageFlip::Emote.process("fahrenheit")).to eq("℉")
        expect(RageFlip::Emote.process("kelvin")).to eq("K")
        expect(RageFlip::Emote.process("rankine")).to eq("°R")
      end

      it "returns math symbols" do
        expect(RageFlip::Emote.process("sqrt")).to eq("√")
        expect(RageFlip::Emote.process("radical")).to eq("√")
        expect(RageFlip::Emote.process("cbrt")).to eq("∛")
        expect(RageFlip::Emote.process("integral")).to eq("∫")
        expect(RageFlip::Emote.process("doubleintegral")).to eq("∬")
        expect(RageFlip::Emote.process("summation")).to eq("∑")
        expect(RageFlip::Emote.process("squared")).to eq("²")
        expect(RageFlip::Emote.process("cubed")).to eq("³")
        expect(RageFlip::Emote.process("plusminus")).to eq("±")
        expect(RageFlip::Emote.process("infty")).to eq("∞")
      end

      it "returns superscript and subscript digits" do
        superscripts = (0..9).map { |d| RageFlip::Emote.process("sup#{d}") }.join
        subscripts = (0..9).map { |d| RageFlip::Emote.process("sub#{d}") }.join
        expect(superscripts).to eq("⁰¹²³⁴⁵⁶⁷⁸⁹")
        expect(subscripts).to eq("₀₁₂₃₄₅₆₇₈₉")
      end

      it "lists math symbols in their own category" do
        math = RageFlip::Emote.get_category_emotes("math")
        expect(math).to include("sqrt", "integral", "squared", "sup2", "sub2")
        expect(math).to all(satisfy { |name| !RageFlip::Emote.emoji_only?(RageFlip::Emote::EMOTES[name]) })
      end

      it "handles case insensitive input" do
        result = RageFlip::Emote.process("DISAPPROVAL")
        expect(result).to eq("(ಠ_ಠ)")
      end

      it "returns nil for unknown emote" do
        result = RageFlip::Emote.process("unknown")
        expect(result).to be_nil
      end
    end

    describe ".list_emotes" do
      it "returns formatted list of all emotes" do
        result = RageFlip::Emote.list_emotes
        expect(result).to include("Available emotes:")
        expect(result).to include("disapproval")
        expect(result).to include("(ಠ_ಠ)")
        expect(result).to include("bullshit")
        expect(result).to include("🐄💩")
      end
    end

    describe ".emote_exists?" do
      it "returns true for existing emote" do
        expect(RageFlip::Emote.emote_exists?("disapproval")).to be true
      end

      it "returns false for non-existing emote" do
        expect(RageFlip::Emote.emote_exists?("nonexistent")).to be false
      end
    end
  end
end
