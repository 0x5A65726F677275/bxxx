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
Installed bxxx v1.2
Copyright (c) 2025 Art of Vector - MIT License
Usage examples:
  bxxx '\x88\x19\xf6\x22' --reverse-endian  # 0x22f61988
  bxxx '0x8819f622' --reverse-endian         # 0x22f61988
  bxxx '48656c6c6f' --char                  # Hello
  bxxx 12345 --hex --little                 # Little-endian output

Manual page installed. View with: man bxxx
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
