# RageFlip

`rage_flip` is a comprehensive Ruby gem that provides text manipulation utilities with clipboard integration. It flips text upside down with rage table flip emoticons, includes extensive text formatting tools, and features a rich collection of emotes and text substitutions for enhanced communication.

Prefer an app? The same functionality is also available [on the App Store](https://apps.apple.com/app/id6827749145).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rage_flip'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install rage_flip
```

## Usage

The gem provides several command-line utilities for text manipulation:

### rage_flip

The main command flips text upside down and adds rage table flip emoticons:

```bash
rage_flip "Hello World"
# Output: (ノಠ益ಠ)ノ彡┻plɹoM ollǝH┻  
# Result is automatically copied to clipboard
```

The flip transformation:
- Reverses the text order
- Maps characters to their upside-down equivalents
- Wraps the result with `(ノಠ益ಠ)ノ彡┻` and `┻`

### table_flip

The classic table flip command flips text upside down with the iconic table flip emoticons:

```bash
table_flip "Hello World"
# Output: (╯°□°)╯︵ plɹoM ollǝH ┻━┻
# Result is automatically copied to clipboard
```

Uses the classic `(╯°□°)╯︵` and `┻━┻` emoticons for a more traditional table flip style.

### flip_text

Flips text upside down without any emoticons:

```bash
flip_text "Hello World"
# Output: plɹoM ollǝH
# Result is automatically copied to clipboard
```

Just the pure flipped text without any rage or table flip decorations.

### emote

The emote system provides a comprehensive collection of emoticons, text substitutions, and emoji sequences:

```bash
emote                    # List all available emotes
emote list               # List all available emotes  
emote disapproval        # Output: (ಠ_ಠ)
emote rage               # Output: ಠ益ಠ
emote flip               # Output: (╯°□°)╯︵ ┻━┻
emote rageflip           # Output: (ノಠ益ಠ)ノ彡┻━┻
emote shrug              # Output: ¯\_(ツ)_/¯
emote fu                 # Output: t(-__-t)
emote facepalm           # Output: (－‸ლ)
emote rock               # Output: \m/ (>_<) \m/
```

#### Shit Emotes
Various poop emoji combinations:

```bash
emote bullshit           # Output: 🐄💩
emote catshit            # Output: 🐱💩
emote dogshit            # Output: 🐶💩
emote pandashit          # Output: 🐼💩
emote horseshit          # Output: 🐴💩
emote koalashit          # Output: 🐨💩
emote batshit            # Output: 🦇💩
```

#### Text Substitutions
Keyboard shortcuts and symbols:

```bash
emote cmd                # Output: ⌘
emote command            # Output: ⌘
emote cmd-               # Output: ⌘-
emote optn               # Output: ⌥
emote option             # Output: ⌥
emote cntl               # Output: ⌃
emote shft               # Output: ⇧
emote shift              # Output: ⇧
```

Temperature units:

```bash
emote celsius            # Output: ℃
emote fahrenheit         # Output: ℉
emote kelvin             # Output: K (U+212A KELVIN SIGN)
emote rankine            # Output: °R
```

Math symbols:

```bash
emote sqrt               # Output: √ (also: radical)
emote cbrt               # Output: ∛ (also: cuberoot; fourthroot is ∜)
emote integral           # Output: ∫ (also: doubleintegral ∬, tripleintegral ∭, contourintegral ∮)
emote summation          # Output: ∑
emote squared            # Output: ²
emote cubed              # Output: ³
emote sup2 sub1          # Output: ²₁ (sup0–sup9, supplus, supminus, supn, sub0–sub9)
emote plusminus          # Output: ± (also: minusplus ∓, approx ≈, notequal ≠, lessequal ≤, greaterequal ≥)
```

#### Special Emotes
Multi-line and unique expressions:

```bash
emote kungfuhamster      # Output: Multi-line ASCII hamster
emote noevil             # Output: 🙈🙉🙊
emote omw                # Output: On my way!
emote bugeyes            # Output: (⊙_◎)
emote dogshrug           # Output: ¯\_🐶_/¯
emote javaflip           # Output: (╯°□°)╯︵ ┻ɐʌɐɾ┻
emote heresatable        # Output: ┬─┬ ノ( ゜-゜ノ)
emote shrugtable         # Output: ┻━┻ ︵ ¯\(ツ)/¯ ︵ ┻━┻
emote unsee              # Output: ♨_♨
emote yuno               # Output: ლ(ಠ益ಠლ)
```

All emotes are accessed through the `emote` command followed by the emote name. Use `emote list` to see the complete collection of available emotes.

### sarcasm

Alternates between uppercase and lowercase characters:

```bash
sarcasm "this is sarcastic"
# Output: ThIs Is SaRcAsTiC
```

### frustrated

Converts text to uppercase with periods between words to express frustration:

```bash
frustrated "one more day"
# Output: ONE. MORE. DAY.
```

### confusable

Swaps every letter for a random lookalike glyph: homoglyphs from other scripts (Cyrillic, Greek, Armenian, Cherokee), unaccented letter variants (dotless ı, small capitals), and allographs (fullwidth, bold, script, fraktur, monospace):

```bash
confusable "hello world"
# Output (random each time): һ𝐞𝓁ⅼ𝔬 ԝｏг𝚕ԁ
```

### strikethrough

Adds strikethrough formatting to text using Unicode combining characters:

```bash
strikethrough "crossed out text"
# Output: c̶r̶o̶s̶s̶e̶d̶ ̶o̶u̶t̶ ̶t̶e̶x̶t̶
```

### underline

Adds single underline formatting:

```bash
underline "underlined text"
# Output: u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲ ̲t̲e̲x̲t̲
```

### doubleunderline

Adds double underline formatting:

```bash
doubleunderline "double underlined"
# Output: d̳o̳u̳b̳l̳e̳ ̳u̳n̳d̳e̳r̳l̳i̳n̳e̳d̳
```

### italic

Swaps letters for slanted Unicode alternatives, or script ones with `--script`. Digits, punctuation, and accented letters are left unchanged:

```bash
italic "italic text"
# Output: 𝑖𝑡𝑎𝑙𝑖𝑐 𝑡𝑒𝑥𝑡

italic --script "script text"
# Output: 𝓈𝒸𝓇𝒾𝓅𝓉 𝓉ℯ𝓍𝓉
```

### latex

Replaces LaTeX-style markup with Unicode symbols. Use single quotes so the shell keeps the backslashes:

```bash
latex '\int_0^1 x^2 dx'
# Output: ∫₀¹ x² dx

latex '\sqrt{x+1} \approx \sqrt[3]{8} \pm \frac{1}{2}'
# Output: √(x+1) ≈ ∛8 ± ½

latex '\alpha + \beta \to \gamma, \forall x \in \emptyset'
# Output: α + β → γ, ∀ x ∈ ∅
```

- `\name` commands cover Greek letters, big operators (`\int`, `\sum`, `\prod`, `\partial`, `\nabla`, `\infty`), operators (`\pm`, `\times`, `\cdot`), relations (`\approx`, `\neq`, `\leq`, `\geq`, `\equiv`), arrows (`\to`, `\Rightarrow`, `\iff`), and sets/logic (`\forall`, `\exists`, `\in`, `\subset`, `\cup`, `\cap`, `\emptyset`). Unknown commands are left as typed.
- `^2`, `^{n+1}`, `_0` and `_{i=1}` become superscripts and subscripts when every character has a Unicode form; otherwise (e.g. `e^{i\pi}`, since there's no superscript π) they're left as typed.
- `\sqrt{x}` → `√x`, `\sqrt{x+1}` → `√(x+1)`, `\sqrt[3]{x}` → `∛x`, `\sqrt[5]{x}` → `⁵√x`.
- `\frac{1}{2}` → `½` when a vulgar fraction exists, otherwise `\frac{a+b}{c}` → `(a+b)/c`.
- Spaces are kept as typed, `$` delimiters pass through, `\left`/`\right` are dropped, and `\{ \} \_ \^ \$ \% \& \# \\` output the escaped character.

### Interrobang substitution

Every text transform (`rage_flip`, `table_flip`, `flip_text`, `sarcasm`, `frustrated`, `confusable`, `strikethrough`, `underline`, `doubleunderline`, `italic`, `latex`, `chaos`) first turns each `?!` or `!?` pair into the interrobang ‽. Pairs are matched left to right, so `?!?!` → `‽‽`, `?!?` → `‽?` and `!!?` → `!‽`; `??` and `!!` are left alone. Flips also turn `?` into `¿` and ‽ into the inverted interrobang ⸘:

```bash
sarcasm "you did what?!"
# Output: YoU DiD WhAt‽

flip_text "really?!"
# Output: ⸘ʎʅʅɐǝɹ
```

For a lone ‽, use `emote interrobangtext` or `latex '\interrobang'` (`emote interrobang` gives the ⁉️ emoji).

### chaos

Adds random Unicode combining characters for a chaotic effect:

```bash
chaos "chaotic text"
# Output: c̸̰̈h̴̲̆a̷̰̋ò̶̰ẗ̸̲ḭ̷̋c̶̰̈ ̸̰̈t̷̰̋ĕ̴̲ẍ̸̰t̷̰̋
```

The chaos level is persistently stored in `~/.chaos_level.txt` and can be controlled with the `chaos_level` command.

### chaos_level

Controls the chaos level for the chaos command:

```bash
chaos_level         # Show current chaos level
chaos_level show    # Show current chaos level  
chaos_level more    # Increase chaos level by 1
chaos_level less    # Decrease chaos level by 1
chaos_level 15      # Set chaos level to 15
```

The default chaos level is 10. Higher numbers create more chaotic effects.

## Platform-Specific Clipboard Support

The gem automatically detects your platform and uses the appropriate clipboard command:

- **macOS**: Uses `pbcopy`
- **Linux**: Uses `xclip` or `xsel` (install one of these first)
- **Windows**: Uses `clip`

All commands automatically copy their output to the clipboard and display the result.

## Character Mappings

The flip functionality uses comprehensive character mappings including:

- Regular alphabet (A-Z, a-z)
- Numbers (0-9)
- Common punctuation and symbols
- Special Unicode characters for upside-down equivalents

## Comprehensive Emote Collection

The gem includes an extensive collection of emotes organized into categories:

### Rage & Flipping
- `disapproval`, `rage`, `flip`, `rageflip`, `javaflip`, `shrugtable`

### Expressions & Gestures  
- `shrug`, `fu`, `facepalm`, `rock`, `bugeyes`, `dogshrug`, `yuno`

### Poop Emotes
- `bullshit`, `catshit`, `dogshit`, `pandashit`, `horseshit`, `koalashit`, `batshit`

### Keyboard Symbols
- `cmd`/`command` (⌘), `optn`/`option` (⌥), `cntl` (⌃), `shft`/`shift` (⇧), `cmd-` (⌘-)

### Temperature Units
- `celsius` (℃), `fahrenheit` (℉), `kelvin` (K), `rankine` (°R)

### Math Symbols
- Roots: `sqrt`/`radical` (√), `cbrt`/`cuberoot` (∛), `fourthroot` (∜)
- Calculus: `integral` (∫), `doubleintegral` (∬), `tripleintegral` (∭), `contourintegral` (∮), `summation` (∑), `prod` (∏), `partialdiff` (∂), `nabla` (∇), `infty` (∞)
- Relations: `plusminus` (±), `minusplus` (∓), `approx` (≈), `notequal` (≠), `lessequal` (≤), `greaterequal` (≥), `equiv` (≡), `propto` (∝)
- Superscripts: `squared` (²), `cubed` (³), `sup0`–`sup9` (⁰–⁹), `supplus` (⁺), `supminus` (⁻), `supn` (ⁿ)
- Subscripts: `sub0`–`sub9` (₀–₉)

### Special Characters
- `noevil` (🙈🙉🙊), `omw` ("On my way!"), `heresatable`, `kungfuhamster` (ASCII art), `unsee`
- `interrobangtext` (‽), next to the `interrobang` (⁉️) and `bangbang` (‼️) emoji

Use `emote list` to see all available emotes with their outputs.

## Persistent Settings

- **Chaos Level**: Stored in `~/.chaos_level.txt` and controls the intensity of the chaos effect (default: 10). This setting persists across terminal sessions and system reboots.

## Library Usage

You can also use the gem programmatically:

```ruby
require 'rage_flip'

# Flip text with rage emoticons
RageFlip::Flipper.rage_flip("Hello World")
# => "(ノಠ益ಠ)ノ彡┻plɹoM ollǝH┻"

# Flip text with classic table flip emoticons  
RageFlip::Flipper.table_flip("Hello World")
# => "(╯°□°)╯︵ plɹoM ollǝH ┻━┻"

# Just flip without emoticons
RageFlip::Flipper.flip("Hello")
# => "ollǝH"

# Flip text (same as flip)
RageFlip::Flipper.flip_text("Hello")
# => "ollǝH"

# Sarcastic text
RageFlip::Sarcasm.process("hello world")
# => "HeLlO WoRlD"

# Frustrated text
RageFlip::Frustrated.process("one more day")
# => "ONE. MORE. DAY."

# Confusable (random lookalike glyphs)
RageFlip::Confusable.process("hello")
# => "һ𝐞𝓁ⅼ𝔬"

# Strikethrough
RageFlip::Strikethrough.process("text")
# => "t̶e̶x̶t̶"

# Underline (single or double)
RageFlip::Underline.single_underline("text")
# => "t̲e̲x̲t̲"

RageFlip::Underline.double_underline("text")
# => "t̳e̳x̳t̳"

# Italic (slanted or script)
RageFlip::Italic.slanted("text")
# => "𝑡𝑒𝑥𝑡"

RageFlip::Italic.script("text")
# => "𝓉ℯ𝓍𝓉"

# LaTeX-style markup to Unicode
RageFlip::Latex.process("\\int_0^1 x^2 dx")
# => "∫₀¹ x² dx"

# Interrobang (applied by every transform above)
RageFlip::Interrobang.process("what?! no!?")
# => "what‽ no‽"

# Chaos
RageFlip::Chaos.process("text", 5)
# => "t̸e̷x̸t̷"

# Emotes
RageFlip::Emote.process("disapproval")
# => "(ಠ_ಠ)"

RageFlip::Emote.process("bullshit")
# => "🐄💩"

RageFlip::Emote.process("cmd")
# => "⌘"

RageFlip::Emote.process("shrug")
# => "¯\_(ツ)_/¯"

RageFlip::Emote.list_emotes
# => "Available emotes:\n  batshit      - 🦇💩\n  bugeyes      - (⊙_◎)\n..."

# Check if emote exists
RageFlip::Emote.emote_exists?("rage")
# => true

# Get all emote names
RageFlip::Emote.emote_names
# => ["disapproval", "bullshit", "catshit", ...]

# Copy to clipboard
RageFlip::Clipboard.copy("text to copy")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

### Version Management

The gem includes comprehensive version management tools:

#### Rake Tasks

```bash
# Show current version
rake version:show

# Bump patch version (1.0.0 -> 1.0.1)
rake version:bump:patch

# Bump minor version (1.0.0 -> 1.1.0)  
rake version:bump:minor

# Bump major version (1.0.0 -> 2.0.0)
rake version:bump:major

# Set specific version
rake version:set[1.2.3]
```

#### Version Script

```bash
# Show current version
./bin/version show

# Bump versions
./bin/version patch
./bin/version minor  
./bin/version major

# Set specific version
./bin/version set 1.2.3
```

#### Release Process

```bash
# Complete release workflow
rake release
# This will: run tests, build gem, create git tag
```

### Automated CI/CD

The project includes GitHub Actions workflows for:
- **Continuous Integration**: Runs tests on Ruby 3.0, 3.1, and 3.2
- **Automated Releases**: Creates GitHub releases when commits start with "Release v"

To create a release:
1. Bump the version: `./bin/version minor`
2. Update CHANGELOG.md with changes
3. Commit: `git commit -am "Release v1.1.0"`  
4. Push: `git push origin main`
5. The CI will automatically create a GitHub release with the built gem

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stringsn88keys/rage_flip_gem.

## License

The gem is available as open source under the terms of the MIT License.
