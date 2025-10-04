# RageFlip

`rage_flip` is a Ruby gem that provides text manipulation utilities with clipboard integration. It flips text upside down with rage table flip emoticons and includes several other text formatting tools.

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

### sarcasm

Alternates between uppercase and lowercase characters:

```bash
sarcasm "this is sarcastic"
# Output: ThIs Is SaRcAsTiC
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

### chaos

Adds random Unicode combining characters for a chaotic effect:

```bash
chaos "chaotic text"
# Output: c̸̰̈h̴̲̆a̷̰̋ò̶̰ẗ̸̲ḭ̷̋c̶̰̈ ̸̰̈t̷̰̋ĕ̴̲ẍ̸̰t̷̰̋
```

The chaos level can be controlled with the `CHAOS_LEVEL` environment variable or the `chaos_level` command.

### chaos_level

Controls the chaos level for the chaos command:

```bash
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

## Environment Variables

- `CHAOS_LEVEL`: Controls the intensity of the chaos effect (default: 10)

## Library Usage

You can also use the gem programmatically:

```ruby
require 'rage_flip'

# Flip text with rage emoticons
RageFlip::Flipper.rage_flip("Hello World")
# => "(ノಠ益ಠ)ノ彡┻plɹoM ollǝH┻"

# Just flip without emoticons
RageFlip::Flipper.flip("Hello")
# => "ollǝH"

# Sarcastic text
RageFlip::Sarcasm.process("hello world")
# => "HeLlO WoRlD"

# Strikethrough
RageFlip::Strikethrough.process("text")
# => "t̶e̶x̶t̶"

# Underline (single or double)
RageFlip::Underline.single_underline("text")
# => "t̲e̲x̲t̲"

RageFlip::Underline.double_underline("text")
# => "t̳e̳x̳t̳"

# Chaos
RageFlip::Chaos.process("text", 5)
# => "t̸e̷x̸t̷"

# Copy to clipboard
RageFlip::Clipboard.copy("text to copy")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stringsn88keys/rage_flip_gem.

## License

The gem is available as open source under the terms of the MIT License.
