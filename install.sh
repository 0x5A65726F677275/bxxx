#!/bin/bash
# bxxx installer v1.2 - Byte Sequence Generator (bxxx) 1.2v
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
bxxx - Advanced Byte Sequence Generator (bxxx) 1.2v
Copyright (c) 2025 Art of Vector
License: MIT License (https://opensource.org/licenses/MIT)

Features:
- Hex/Decimal/Octal/ASCII conversions
- Endianness control (big/little)
- Little-endian to big-endian conversion
"""

import argparse
import sys
import re

def convert_value(value, fmt, endian='big'):
    try:
        # Handle hex input (both 0x and \x formats)
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
        # Handle \x format
        if hex_str.startswith('\\x'):
            bytes_list = re.findall(r'\\x([0-9a-fA-F]{2})', hex_str)
        # Handle 0x format
        elif hex_str.startswith('0x'):
            hex_str = hex_str[2:]
            bytes_list = [hex_str[i:i+2] for i in range(0, len(hex_str), 2)]
        # Handle plain hex
        elif all(c in '0123456789abcdefABCDEF' for c in hex_str):
            bytes_list = [hex_str[i:i+2] for i in range(0, len(hex_str), 2)]
        else:
            raise ValueError("Input must be in \\xHH, 0xHH, or plain hex format")
            
        if not bytes_list:
            raise ValueError("No valid hex bytes found")
            
        # Pad odd-length strings with leading zero
        if len(bytes_list[-1]) == 1:
            bytes_list[-1] = '0' + bytes_list[-1]
            
        reversed_hex = ''.join(reversed(bytes_list))
        return f"0x{reversed_hex}"
    except Exception as e:
        raise ValueError(f"Endian reversal failed: {str(e)}")

def main():
    parser = argparse.ArgumentParser(
        description="bxxx - Advanced Hex Converter (Art of Vector)",
        epilog="Examples:\n  bxxx '\\x88\\x19\\xf6\\x22' --reverse-endian → 0x22f61988\n  bxxx '0x8819f622' --reverse-endian → 0x22f61988"
    )
    parser.add_argument('value', help="Input value (0x hex, decimal, or \\x hex string)")
    parser.add_argument('--char', action='store_true', help='ASCII output (big-endian)')
    parser.add_argument('--hex', action='store_true', help='Hex output (default: big-endian)')
    parser.add_argument('--dec', action='store_true', help='Decimal output')
    parser.add_argument('--oct', action='store_true', help='Octal output')
    parser.add_argument('--big', action='store_const', dest='endian', const='big', default='big',
                       help='Big-endian output (default)')
    parser.add_argument('--little', action='store_const', dest='endian', const='little',
                       help='Little-endian output')
    parser.add_argument('--reverse-endian', action='store_true',
                       help='Convert hex to big-endian (supports \\x, 0x, and plain hex)')
    
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
bxxx \- Advanced Byte Sequence Generator
.SH SYNOPSIS
.B bxxx
[\fIVALUE\fR] [\fIOPTIONS\fR]
.SH DESCRIPTION
bxxx is a versatile byte sequence generator that converts between hexadecimal, decimal, octal, and ASCII representations with endianness control.
.SH OPTIONS
.TP
\fB\-\-char\fR
ASCII output (big-endian)
.TP
\fB\-\-hex\fR
Hex output (default: big-endian)
.TP
\fB\-\-dec\fR
Decimal output
.TP
\fB\-\-oct\fR
Octal output
.TP
\fB\-\-big\fR
Big-endian output (default)
.TP
\fB\-\-little\fR
Little-endian output
.TP
\fB\-\-reverse\-endian\fR
Convert hex to big-endian (supports \\x, 0x, and plain hex)
.SH EXAMPLES
.TP
Convert hex string to big-endian:
.B bxxx '\\x88\\x19\\xf6\\x22' \-\-reverse\-endian
(Result: 0x22f61988)
.TP
Convert 0x hex to big-endian:
.B bxxx '0x8819f622' \-\-reverse\-endian
(Result: 0x22f61988)
.TP
Convert hex to ASCII:
.B bxxx 0x48656c6c6f \-\-char
(Result: Hello)
.TP
Convert decimal to little-endian hex:
.B bxxx 586553736 \-\-hex \-\-little
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
echo "  bxxx '\\x88\\x19\\xf6\\x22' --reverse-endian  # 0x22f61988"
echo "  bxxx '0x8819f622' --reverse-endian         # 0x22f61988"
echo "  bxxx '48656c6c6f' --char                  # Hello"
echo "  bxxx 12345 --hex --little                 # Little-endian output"
echo ""
echo "Manual page installed. View with: man bxxx"
