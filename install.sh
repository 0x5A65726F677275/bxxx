#!/bin/bash
# bxxx installer v1.2 - Byte Sequence Generator (bxxx) 1.2
# Copyright (c) 2025 Art of Vector
# License: MIT License (https://opensource.org/licenses/MIT)
# Install: curl -sSL https://raw.githubusercontent.com/0x5A65726F677275/bxxx/main/install.sh | sudo bash

set -e

VERSION="1.2"
INSTALL_DIR="/usr/local/bin"
MAN_DIR="/usr/local/share/man/man1"

# Create installation directory if it doesn't exist
mkdir -p "${INSTALL_DIR}"
mkdir -p "${MAN_DIR}"

# Install the main script
cat > "${INSTALL_DIR}/bxxx" << 'EOF'
#!/usr/bin/env python3
"""
bxxx - Advanced Byte Sequence Generator (bxxx) 1.2
Copyright (c) 2025 Art of Vector
License: MIT License (https://opensource.org/licenses/MIT)

Features:
- Hex/Decimal/Octal/ASCII conversions
- Endianness control (big/little)
- Hex string endian conversion
"""

import argparse
import sys
import re

def convert_value(value, fmt, endian='big'):
    try:
        if value.startswith('\\x'):
            hex_str = value.replace('\\x', '')
            num = int(hex_str, 16)
        else:
            num = int(value, 16) if value.startswith('0x') else int(value)
        
        if fmt == 'char':
            byte_length = (num.bit_length() + 7) // 8
            bytes = num.to_bytes(byte_length, 'big')
            return ''.join(chr(b) if 32 <= b <= 126 else '.' for b in bytes)
            
        elif fmt == 'hex':
            byte_length = (num.bit_length() + 7) // 8
            bytes = num.to_bytes(byte_length, endian)
            return ''.join(f'\\x{b:02x}' for b in bytes)
            
        elif fmt == 'dec':
            return str(num)
            
        elif fmt == 'oct':
            return oct(num)[2:]
    except ValueError as e:
        raise ValueError(f"Invalid input: {value}")

def reverse_endian(hex_str):
    """Convert hex string to big-endian hex"""
    try:
        if hex_str.startswith('\\x'):
            bytes_list = re.findall(r'\\x([0-9a-fA-F]{2})', hex_str)
        elif hex_str.startswith('0x'):
            hex_str = hex_str[2:]
            bytes_list = [hex_str[i:i+2] for i in range(0, len(hex_str), 2)]
        elif all(c in '0123456789abcdefABCDEF' for c in hex_str):
            bytes_list = [hex_str[i:i+2] for i in range(0, len(hex_str), 2)]
        else:
            raise ValueError("Input must be in \\xHH, 0xHH, or plain hex")
            
        if not bytes_list:
            raise ValueError("No valid hex bytes found")
            
        if len(bytes_list[-1]) == 1:
            bytes_list[-1] = '0' + bytes_list[-1]
            
        return f"0x{''.join(reversed(bytes_list))}"
    except Exception as e:
        raise ValueError(f"Endian reversal failed: {str(e)}")

def main():
    parser = argparse.ArgumentParser(
        description="bxxx - Byte Sequence Converter",
        epilog="Examples:\n  bxxx '\\x88\\x19\\xf6\\x22' --reverse-endian → 0x22f61988\n  bxxx 12345 --hex --little"
    )
    parser.add_argument('value', help="Input (0x hex, decimal, or \\x hex string)")
    parser.add_argument('--char', action='store_true', help='ASCII output')
    parser.add_argument('--hex', action='store_true', help='Hex output')
    parser.add_argument('--dec', action='store_true', help='Decimal output')
    parser.add_argument('--oct', action='store_true', help='Octal output')
    parser.add_argument('--big', action='store_const', dest='endian', const='big', default='big',
                       help='Big-endian (default)')
    parser.add_argument('--little', action='store_const', dest='endian', const='little',
                       help='Little-endian')
    parser.add_argument('--reverse-endian', action='store_true',
                       help='Convert hex to big-endian')
    
    args = parser.parse_args()
    
    try:
        if args.reverse_endian:
            print(reverse_endian(args.value))
        elif args.char:
            print(convert_value(args.value, 'char'))
        elif args.hex:
            print(convert_value(args.value, 'hex', args.endian))
        elif args.dec:
            print(convert_value(args.value, 'dec'))
        elif args.oct:
            print(convert_value(args.value, 'oct'))
        else:
            print(convert_value(args.value, 'hex', args.endian))
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
EOF

# Install the man page
cat > "${MAN_DIR}/bxxx.1" << 'EOF'
.TH BXXX 1 "2025-05-17" "bxxx v1.2" "Byte Sequence Generator"
.SH NAME
bxxx \- Byte sequence conversion tool
.SH SYNOPSIS
.B bxxx
[\fIVALUE\fR] [\fIOPTIONS\fR]
.SH DESCRIPTION
Convert between numeric formats with endianness control. Supports hexadecimal, decimal, octal, and ASCII conversions.
.SH OPTIONS
.TP
\fB\-\-char\fR
Show ASCII representation
.TP
\fB\-\-hex\fR
Show hexadecimal representation
.TP
\fB\-\-dec\fR
Show decimal representation
.TP
\fB\-\-oct\fR
Show octal representation
.TP
\fB\-\-big\fR
Use big-endian byte order (default)
.TP
\fB\-\-little\fR
Use little-endian byte order
.TP
\fB\-\-reverse\-endian\fR
Convert between endian formats
.SH EXAMPLES
.TP
Convert little-endian hex to big-endian:
.B bxxx \\x88\\x19\\xf6\\x22 \-\-reverse\-endian
.TP
Show ASCII representation:
.B bxxx 0x48656c6c6f \-\-char
.TP
Convert decimal to little-endian hex:
.B bxxx 12345 \-\-hex \-\-little
.SH AUTHOR
Art of Vector
.SH LICENSE
MIT License
.SH SEE ALSO
hexdump(1), xxd(1)
EOF

# Update man database
mandb -q >/dev/null 2>&1 || true

chmod +x "${INSTALL_DIR}/bxxx"
echo "Installed bxxx v${VERSION}"
echo "Copyright (c) 2025 Art of Vector - MIT License"
echo "Usage examples:"
echo "  bxxx '\\x88\\x19\\xf6\\x22' --reverse-endian"
echo "  bxxx 0x48656c6c6f --char"
echo "  bxxx 12345 --hex --little"
echo ""
echo "Manual page installed. View with: man bxxx"
