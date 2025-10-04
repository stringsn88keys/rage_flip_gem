# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Version management and release automation

## [1.0.0] - 2025-10-03

### Added
- Initial release of RageFlip gem
- `rage_flip` command for upside-down text with rage emoticons
- `sarcasm` command for alternating case text
- `strikethrough` command for strikethrough formatting
- `underline` command for single underline formatting  
- `doubleunderline` command for double underline formatting
- `chaos` command for chaotic text with combining characters
- `chaos_level` command for controlling chaos intensity
- Cross-platform clipboard support (macOS, Linux, Windows)
- Comprehensive test suite
- Complete Ruby API for programmatic usage

### Features
- Unicode character mapping for upside-down text transformation
- Environment variable support for chaos level configuration
- Automatic clipboard copying for all commands
- Platform detection and appropriate clipboard tool usage