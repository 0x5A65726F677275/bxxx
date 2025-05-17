# Byte Sequence Generator (bxxx) 1.2v 🛠️
![Banner](/image/1.2V.png)

![License](https://img.shields.io/badge/License-MIT-blue)
![Python](https://img.shields.io/badge/Python-3.6+-blue)
![Platform](https://img.shields.io/badge/Platform-Linux%20|%20macOS-lightgrey)

**Convert memory addresses to byte sequences** with this powerful command-line tool designed for binary exploitation, reverse engineering, and low-level programming.
## Features ✨

- 🔢 Convert hex/dec addresses to `\xXX` byte sequences
- ⚙️ Configurable byte length and null byte handling
- 📚 Comprehensive man pages and documentation
- 🐧 System-wide installation for all users
- 🛡️ BSD licensed - free for personal and commercial use

## Quick Install 🚀

```bash
curl -sSL https://raw.githubusercontent.com/0x5A65726F677275/bxxx/main/install.sh | sudo bash
```

## Usage Examples 💡
### Basic conversion
```bash
aov@ArtOfVector-Lab:~$ bxxx --help
usage: bxxx [-h] [--char] [--hex] [--dec] [--oct] [--big] [--little] [--reverse-endian] value

bxxx - Advanced Hex Converter (Art of Vector)

positional arguments:
  value             Input value (0x hex, decimal, or \x hex string)

options:
  -h, --help        show this help message and exit
  --char            ASCII output (big-endian)
  --hex             Hex output (default: big-endian)
  --dec             Decimal output
  --oct             Octal output
  --big             Big-endian output (default)
  --little          Little-endian output
  --reverse-endian  Convert \x little-endian to 0x big-endian

Example: bxxx '\x88\x19\xf6\x22' --reverse-endian → 0x22f61988
```

# View full documentation
```bash
man bxxx
```
## Why bxxx? 🤔
Perfect for exploit development and binary analysis

Essential tool for CTF players and security researchers

Lightweight (only 3KB installed) with zero dependencies

Works in resource-constrained environments

## Contributing 🤝
Pull requests welcome! Please see our contribution guidelines.

Developed with ❤️ by Art of Vector
