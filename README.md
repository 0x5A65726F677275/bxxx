# Byte Sequence Generator (bxxx) 🛠️
![image](https://github.com/user-attachments/assets/4d5cb8f0-4776-4afb-925a-16e80592cafe)

![License](https://img.shields.io/badge/License-BSD-blue)
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
# Basic conversion
```bash
bxxx 0x414243  # Output: \x41\x42\x43
```
# Fixed length conversion
```bash
bxxx -b 8 0xdeadbeef  # Output: \xef\xbe\xad\xde\x00\x00\x00\x00
```
# Keep null bytes
```bash
bxxx -k 0x1234  # Output: \x34\x12
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
