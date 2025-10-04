# rage_flip

`rage_flip` is a Ruby gem that allows you to flip all arguments passed to it and copy the result to your clipboard. It provides a simple command-line interface for quick usage and is designed to work across different platforms.

## Installation

To install the `rage_flip` gem, you can use the following command:

```bash
gem install rage_flip
```

## Usage

Once installed, you can use the `rage_flip` command in your terminal. Here’s how to use it:

```bash
rage_flip arg1 arg2 arg3
```

This command will flip the order of the arguments and copy the result to your clipboard.

### Example

```bash
$ rage_flip hello world
```

This will result in `world hello` being copied to your clipboard.

## Executables

The `rage_flip` gem includes the following executables:

- `rage_flip`: The main command to flip arguments and copy to clipboard.
- `console`: An interactive console for testing and experimenting with the gem.
- `setup`: A script to set up the development environment.

## Platform-Specific Clipboard Commands

The gem uses platform-specific commands to copy text to the clipboard:

- **macOS**: Uses `pbcopy`
- **Linux**: Uses `xclip` or `xsel` (ensure one of these is installed)
- **Windows**: Uses `clip`

## Aliases and Ruby Scripts

The gem also supports the following aliases and Ruby scripts from Zsh:

- `flip`: An alias for `rage_flip`.
- `reverse`: Another alias that performs the same functionality.

## Contributing

If you would like to contribute to the `rage_flip` gem, please fork the repository and submit a pull request. Make sure to include tests for any new features or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.