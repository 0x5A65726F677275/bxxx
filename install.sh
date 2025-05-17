#!/bin/bash
# bxxx installer v1.2 - Byte Sequence Generator (bxxx) 1.2v
# Copyright (c) 2025 Art of Vector
# License: MIT License (https://opensource.org/licenses/MIT)
# Install: curl -sSL https://raw.githubusercontent.com/0x5A65726F677275/bxxx/main/install.sh | sudo bash

set -e

VERSION="1.3"
INSTALL_DIR="/usr/local/bin"

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
    """Convert little-endian hex string to big-endian hex"""
    try:
        bytes_list = re.findall(r'\\x([0-9a-fA-F]{2})', hex_str)
        if not bytes_list:
            raise ValueError("Invalid hex string format")
        reversed_hex = ''.join(reversed(bytes_list))
        return f"0x{reversed_hex}"
    except Exception as e:
        raise ValueError(f"Endian reversal failed: {e}")

def main():
    parser = argparse.ArgumentParser(
        description="bxxx - Advanced Hex Converter (Art of Vector)",
        epilog="Example: bxxx '\\x88\\x19\\xf6\\x22' --reverse-endian → 0x22f61988"
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
                       help='Convert \\x little-endian to 0x big-endian')
    
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

chmod +x "${INSTALL_DIR}/bxxx"
echo "Installed bxxx v${VERSION}"
echo "Copyright (c) 2025 Art of Vector - MIT License"
echo "Usage examples:"
echo "  bxxx '\\x88\\x19\\xf6\\x22' --reverse-endian  # 0x22f61988"
echo "  bxxx 0x48656c6c6f --char    # Hello"
echo "  bxxx 586553736 --hex --little  # Little-endian output"
