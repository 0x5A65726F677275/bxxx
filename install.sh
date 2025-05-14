#!/bin/bash
# bxxx installer - Clean String Version
# Install: curl -sSL https://example.com/install.sh | sudo bash

set -e

VERSION="1.1"
INSTALL_DIR="/usr/local/bin"

cat > "${INSTALL_DIR}/bxxx" << 'EOF'
#!/usr/bin/env python3
import argparse
import sys

def convert_value(value, fmt):
    try:
        num = int(value, 16) if value.startswith('0x') else int(value)
        
        if fmt == 'char':
            # Always big-endian for strings
            byte_length = (num.bit_length() + 7) // 8
            bytes = num.to_bytes(byte_length, 'big')
            return ''.join(chr(b) if 32 <= b <= 126 else '.' for b in bytes)
            
        elif fmt == 'hex':
            bytes = num.to_bytes((num.bit_length() + 7) // 8, 'little')
            return ''.join(f'\\x{b:02x}' for b in bytes)
            
        elif fmt == 'dec':
            return str(num)
            
        elif fmt == 'oct':
            return oct(num)[2:]
    except ValueError as e:
        raise ValueError(f"Invalid input: {value}")

def main():
    parser = argparse.ArgumentParser(description="Clean String Converter")
    parser.add_argument('value', help="Input value (0x hex or decimal)")
    parser.add_argument('--char', action='store_true', help='ASCII output')
    parser.add_argument('--hex', action='store_true', help='Hex output')
    parser.add_argument('--dec', action='store_true', help='Decimal output')
    parser.add_argument('--oct', action='store_true', help='Octal output')
    
    args = parser.parse_args()
    
    try:
        if args.char:
            print(convert_value(args.value, 'char'))
        elif args.hex:
            print(convert_value(args.value, 'hex'))
        elif args.dec:
            print(convert_value(args.value, 'dec'))
        elif args.oct:
            print(convert_value(args.value, 'oct'))
        else:
            print(convert_value(args.value, 'hex'))
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
EOF

chmod +x "${INSTALL_DIR}/bxxx"
echo "Installed bxxx v${VERSION}"
echo "Usage: bxxx 0x48656c6c6f --char  # Always outputs 'Hello'"
