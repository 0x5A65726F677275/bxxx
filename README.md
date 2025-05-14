# Byte Sequence Generator (bxxx) 1.1v 🛠️
![image](https://lh3.googleusercontent.com/fife/ALs6j_Fn8LkTutQL03hTaCiC2x0TpgQBhqEK0LB5c3xNtYvXe7Gd_fYXJrlA3HmUG9ErhYB3UWgXx0D87pcTSdwrE6eG6MmHQLAlidP5jnFUu-vE4wuQnbNxy96yQinUnEwIA9QOF9kxVt3NjRzqKjNx77e4HmD6EB3i5GX9UvSs2hcUE4YDbGQmEog7AdnQ-OgbNfewVX_c3G1bM9hsWO3ZkyZMv-B-DOfir9DmHdn0cFsLpa045S1XnVc_MwAMoLUZkW_OU6pWy56-p4otBGDtgNLcIBzsh_1t6S7HdqGzDqLhzNycXbtWr0mqtMUQczPJEJtoK7LxeTwuJ7nd7Zpwp6CnFJph-KJlkSVoCftvEqxjV2oM-dg3GpvGRU6d1RhgunU6w2U9qDv806M6O_kAiq09db4zaTBF7GBCr0jxo1PiOhUpYUsGGW0iQ2vXRxBhFnXBKBkjDOoUIJU_Gz0XQsOTfwJ-6miMu5G2W51Tq8sc-DHX0khm1c7N6HWKeqO_tJmWnzbs6kjv4BZhIX23VwpwhreL7LlcffJVDnr4k73HuGpycrow97PmC6pk4VfjTF4tRsalhYjU44Xynu-IxlB4EpQ7m0PRZgfWx2r2Pnzg_YHsCFOB0yHETYS6_54UOHpY_q639zijXF-eG9xDvJZbO5YlBgAuAa1djb5QKZW6zSjEjbqvCXKKwKnKJqj2uSHeTS7Z0v5eW_R9hUtingOwgIjD0hzT0iJil6DmNlfivB8dYXiMF7z2E122yLSUXTLZqlRfRR40R3O6DSc7mrY9gJKKe-C2HB4xJ3GaSQ3qDwk8J3A6dD5xIRhH4CyUR_TI54kjUE7xOuYlbxXKYjgw1APkVWQfVy9Kim2CI_Dkf_Uxi8LU5F1JfDdOAoz_khLgQcfZh6sdrKmuFqxpz5yeojhZ7ynyoEGDLR4B7W-9qwWtfYFnZZHDHH823HwFCuT7_pPLsrnImig3n3nyOiYzJ8slufaI_IogP0l-h2rF1hU2y9yeOMB9T-O3hGhgHekCW46z2UDXFf7ln6MUxZJjjQP96mplBH5dsz4FLQjQ6GMJXIzdCqHbS8wf-mU9Jlue6YfOqb_F19XoLgISEbNNhDRk9q5jFnijXmaVgWQcmjCCeLE99LcpKtG4hzj8TW5Ma9vh6pxOPq890edS2w__3vl45JovMXriDN8wHskxUHVqxjYQHpvlL_1C1plCKoYx6-6X8xA-6_fUzV3bH9y83_SVb4abXSNG7R1BQL1f6HK8xCVEKNaaHZ9D-0RzWXUwdhzWdaHgO3O10Vv5j-RxEWeufdV4uixqiO5ti8VfB5rb-vhdw3rv8Uh6lwcaiConasuC6XIkid73SFiRb-bg8BbIaEsqAPYJ4LHxBDEgaG28IAQWSA=s1024)

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
# Added multiple output formats (--hex, --dec, --oct, --char)
```bash
bxxx --char 0x48656c6c6f    # Outputs "Hello"
bxxx --dec 0xff             # Shows "255"
bxxx --oct 0x41             # Displays "101"
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
