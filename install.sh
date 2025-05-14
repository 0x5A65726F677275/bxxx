#!/bin/bash
# bxxx installer - Art of Vector
# Quick install: curl -sSL https://raw.githubusercontent.com/0x5A65726F677275/bxxx/main/install.sh | sudo bash

set -e

VERSION="1.1"
INSTALL_DIR="/usr/local/bin"
MAN_DIR="/usr/local/share/man/man1"
DOC_DIR="/usr/local/share/doc/bxxx"

# Check root
if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Please run with sudo or as root" >&2
    exit 1
fi

# Create dirs
mkdir -p "${INSTALL_DIR}" "${MAN_DIR}" "${DOC_DIR}"

# Install main script
echo "Installing bxxx v${VERSION}..."
cat > "${INSTALL_DIR}/bxxx" << 'EOF'
#!/usr/bin/env python3
import argparse
import sys

def bxxx(address, byte_length=None, remove_null=True):
    if isinstance(address, str):
        address = address.strip().lower()
        if address.startswith("0x"):
            address = address[2:]
        num = int(address, 16)
    else:
        num = address

    if byte_length is None:
        byte_length = (num.bit_length() + 7) // 8

    try:
        byte_sequence = num.to_bytes(byte_length, byteorder='little')
    except OverflowError:
        raise ValueError(f"Value requires more than {byte_length} bytes!")

    if remove_null:
        byte_sequence = byte_sequence.rstrip(b'\x00')
    return byte_sequence

def main():
    parser = argparse.ArgumentParser(description="Byte Sequence Generator v1.1")
    format_group = parser.add_mutually_exclusive_group()
    format_group.add_argument('--hex', action='store_true', help='Hex format (default)')
    format_group.add_argument('--dec', action='store_true', help='Decimal format')
    format_group.add_argument('--oct', action='store_true', help='Octal format')
    format_group.add_argument('--char', action='store_true', help='ASCII characters')
    
    parser.add_argument('address', help="Numeric value to convert")
    parser.add_argument('-b', '--bytes', type=int, help="Force byte length")
    parser.add_argument('-k', '--keep-null', action='store_false', help="Keep null bytes")
    args = parser.parse_args()

    try:
        bytes = bxxx(args.address, args.bytes, args.keep_null)
        if args.char:
            print(''.join(chr(b) if 32 <= b <= 126 else '.' for b in bytes))
        elif args.dec:
            print(' '.join(map(str, bytes)))
        elif args.oct:
            print(' '.join(f"{b:03o}" for b in bytes))
        else:
            print(''.join(f'\\x{b:02x}' for b in bytes))
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
EOF

# Install man page
cat > "${MAN_DIR}/bxxx.1" << 'EOF'
.TH BXXX 1
.SH NAME
bxxx \- Byte format converter
.SH SYNOPSIS
.B bxxx
[\fIOPTIONS\fR] \fIVALUE\fR
.SH DESCRIPTION
Convert values between hex/dec/oct/ASCII formats.
.SH OPTIONS
.TP
\fB\-\-hex\fR
Hex format (\\x41) [default]
.TP
\fB\-\-dec\fR
Decimal (65)
.TP
\fB\-\-oct\fR
Octal (0101)
.TP
\fB\-\-char\fR
ASCII ('A')
.TP
\fB\-b\fR \fIN\fR
Force N-byte output
.TP
\fB\-k\fR
Keep null bytes
.SH EXAMPLES
  bxxx 0x41 --char       # A
  bxxx 65 --hex          # \\x41
  bxxx 0101 --oct        # 0101
.SH AUTHORS
Art of Vector
EOF

# Set permissions
chmod 755 "${INSTALL_DIR}/bxxx"
mandb >/dev/null 2>&1

echo "Success! Installed:"
echo "  /usr/local/bin/bxxx"
echo "Usage examples:"
echo "  bxxx 0x4142 --char    # AB"
echo "  bxxx 65 --hex         # \\x41"
