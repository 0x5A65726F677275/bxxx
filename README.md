# Byte Sequence Generator (bxxx) 🛠️
[![image](https://github.com/user-attachments/assets/bf93ae60-ea91-443d-8153-59765052fb83)
](https://lh3.googleusercontent.com/fife/ALs6j_HsTevBdZ0LORVPeoLyUEDX2ZKgmagDhw2b24krnk9r4G4tgG4UYboOak5f633CTM6S6jgK2DbWEiP2_NLbw4g73tKIoRdx3e09qWqODh-dOmeSIsIdcqf-jr5YeryKQk1ZyIyTPIsJd2Vlj20U5yNGSNBOj4FajXkGaeSDjjt-7Zxz7QjHVKRgrPQm94yOpiLGgz2uaMgllBpjbvXq-xMJdM2aTMABD2ltiNnxVAdugXU6NMQc0dyhebe3sPGjEPCl2OSVmRNlhLMckQgQjoR5cQoBYFcHYKYmobZEIibw1n1x9VxWc_da1lAOI_8iSXjOqKC1PPydaycjVwmkc8lhOHMvWr9rZqlmraaY57FeA0ktWKXjFoT5iX4psCC-FSHJ-WXCLV_SpxVgh0qoMfkBfnJg_3KSgVGfFqBJkV2K3pjp1P3wyii90LbJtSdqPPlp8AW2nf64J0HNTXe4j26kzHXEaB0QWZMEnfvL3g8AW2T_-tEZD-iSe-w8f7DaqOJosElNUuG7GG7BwHSyY7MEgs0akI8l-hv2s4wdz-1hdnNwbJj746oNrvrTJPLWgfcxpF7GhwynxRXeNFjnKmA8ISNVaPwHFG5l269FhRDlIoIO9mrDArbUmYSiW6fcKzEC109CoxGi3yNJLVc30A8it5gfzF2HtNVHnSY9GXfv5jjRHumB-CW2v-1gQnKd0D6BjbOZbG_YP2E9Zot8reU1TD7IhtIbQ0p9AmQ9ut-rH7qnQdBcGLXw7kjAr3ESEHVV-unwe6RkcSls4WztE3ZIeaQ3dBhDn6lL_tVUkHw0G9_ja3VEshn1bpLDONV1lQWuP3rbRThgFjYw-enPviKGpgTedfMF-J6J5XBOl9TPLt-4CzgOnUfYt7WXv9OPtSRX9MfjbS5TdcgwyUtSddVrlEl-xLJG9XOYptuHcM2qCsISESrY0X4Xc2P8_ry7xucKRhOkPZG3rKgquwCl2qlWF3NlG-B-HdiYIH08lqHVOVo1f2S8dpwY5cWCuBjKXTWdjp-5phvoMcc_PTAeWwpJ3sz1m_eTHTJtCZczCuXJSSOISMrtPMZiDyHkPcYgpx1ZNn0F-Cpg4NgMHMY302ZnUJ4zVinXI6w_t98AzMFQR9BbDXSrmF8rhSGOsNryswkT6t4to2HHpl6L8N8GvO-MacQutA7Tp6r7wm5ArMcYP8Y6xdP2tSITQ3rNZCCenlhTh4ZZQdP8uAsp3b7kH0RamdpMbfbcB00mIc0PQZXpvNYhRZ-6TEqV6zMn2mxLCnLlp5LSuMqhvenY1wmxbdQo4Q4nr1bezd0Q6lT1PgSflowfz48a9ybRArtYXRlA_7ppfOB9VH5UML5GVVRGfSXLaj-EuJ5MsqbkRtE-_JxXsUaY5SQ=s512)
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
