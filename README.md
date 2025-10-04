# RageFlip# rage_flip



`rage_flip` is a Ruby gem that provides text manipulation utilities with clipboard integration. It flips text upside down with rage table flip emoticons and includes several other text formatting tools.`rage_flip` is a Ruby gem that allows you to flip all arguments passed to it and copy the result to your clipboard. It provides a simple command-line interface for quick usage and is designed to work across different platforms.



## Installation## Installation



Add this line to your application's Gemfile:To install the `rage_flip` gem, you can use the following command:



```ruby```bash

gem 'rage_flip'gem install rage_flip

``````



And then execute:## Usage



```bashOnce installed, you can use the `rage_flip` command in your terminal. Here’s how to use it:

bundle install

``````bash

rage_flip arg1 arg2 arg3

Or install it yourself as:```



```bashThis command will flip the order of the arguments and copy the result to your clipboard.

gem install rage_flip

```### Example



## Usage```bash

$ rage_flip hello world

The gem provides several command-line utilities for text manipulation:```



### rage_flipThis will result in `world hello` being copied to your clipboard.



The main command flips text upside down and adds rage table flip emoticons:## Executables



```bashThe `rage_flip` gem includes the following executables:

rage_flip "Hello World"

# Output: (ノಠ益ಠ)ノ彡┻plɹoM ollǝH┻- `rage_flip`: The main command to flip arguments and copy to clipboard.

# Result is automatically copied to clipboard- `console`: An interactive console for testing and experimenting with the gem.

```- `setup`: A script to set up the development environment.



The flip transformation:## Platform-Specific Clipboard Commands

- Reverses the text order

- Maps characters to their upside-down equivalentsThe gem uses platform-specific commands to copy text to the clipboard:

- Wraps the result with `(ノಠ益ಠ)ノ彡┻` and `┻`

- **macOS**: Uses `pbcopy`

### sarcasm- **Linux**: Uses `xclip` or `xsel` (ensure one of these is installed)

- **Windows**: Uses `clip`

Alternates between uppercase and lowercase characters:

## Aliases and Ruby Scripts

```bash

sarcasm "this is sarcastic"The gem also supports the following aliases and Ruby scripts from Zsh:

# Output: ThIs Is SaRcAsTiC

```- `flip`: An alias for `rage_flip`.

- `reverse`: Another alias that performs the same functionality.

### strikethrough

## Contributing

Adds strikethrough formatting to text using Unicode combining characters:

If you would like to contribute to the `rage_flip` gem, please fork the repository and submit a pull request. Make sure to include tests for any new features or bug fixes.

```bash

strikethrough "crossed out text"## License

# Output: c̶r̶o̶s̶s̶e̶d̶ ̶o̶u̶t̶ ̶t̶e̶x̶t̶

```This project is licensed under the MIT License. See the LICENSE file for more details.

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