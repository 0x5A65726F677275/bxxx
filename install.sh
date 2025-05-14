#!/bin/bash
# bxxx installer - Art of Vector
# Installs byte sequence generator tool system-wide with enhanced output formats

set -e

VERSION="1.1"
INSTALL_DIR="/usr/local/bin"
MAN_DIR="/usr/local/share/man/man1"
DOC_DIR="/usr/local/share/doc/bxxx"

# Check root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

# Create installation directories
echo "Creating directories..."
mkdir -p "${INSTALL_DIR}" "${MAN_DIR}" "${DOC_DIR}"

# Install main script with enhanced formatting options
echo "Installing enhanced bxxx tool..."
cat > "${INSTALL_DIR}/bxxx" << 'EOF'
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Byte Sequence Generator - Art of Vector
Version 1.1 (Enhanced Output Formats)
"""

import argparse
import sys

def bxxx(address, byte_length=None, remove_null=True):
    """Convert address to byte sequence."""
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
        raise ValueError(f"Address 0x{num:x} requires more than {byte_length} bytes!")

    if remove_null:
        byte_sequence = byte_sequence.rstrip(b'\x00')

    return byte_sequence

def main():
    parser = argparse.ArgumentParser(
        description="Byte Sequence Generator - Art of Vector",
        epilog="Example: bxxx 0x414243 --char -> AB"
    )
    parser.add_argument('address', help="Address in hex (0x...) or decimal format")
    
    format_group = parser.add_mutually_exclusive_group()
    format_group.add_argument('--hex', action='store_true', help='Hex format (default: \\xXX)')
    format_group.add_argument('--dec', action='store_true', help='Decimal format')
    format_group.add_argument('--oct', action='store_true', help='Octal format (3 digits)')
    format_group.add_argument('--char', action='store_true', 
                            help='ASCII characters (non-printables as .)')

    parser.add_argument('-b', '--bytes', type=int, help="Force specific byte length")
    parser.add_argument('-k', '--keep-null', action='store_false',
                      help="Keep null bytes in output")
    parser.add_argument('-v', '--version', action='version', version='%(prog)s 1.1')

    args = parser.parse_args()

    try:
        byte_sequence = bxxx(args.address, args.bytes, args.keep_null)
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    # Determine output format
    if args.char:
        output = ''.join([chr(b) if 32 <= b <= 126 else '.' for b in byte_sequence])
    elif args.dec:
        output = ' '.join(map(str, byte_sequence))
    elif args.oct:
        output = ' '.join(f"{b:03o}" for b in byte_sequence)
    else:
        output = ''.join(f'\\x{b:02x}' for b in byte_sequence)

    print(output)

if __name__ == "__main__":
    main()
EOF

# Set permissions
chmod 755 "${INSTALL_DIR}/bxxx"

# Install updated man page
echo "Installing enhanced documentation..."
cat > "${MAN_DIR}/bxxx.1" << 'EOF'
.TH BXXX 1 "2024-03-20" "1.1" "Byte Sequence Generator"
.SH NAME
bxxx \- Convert addresses to multiple byte formats
.SH SYNOPSIS
.B bxxx
[\fIOPTIONS\fR] \fIADDRESS\fR
.SH DESCRIPTION
Convert numeric values to various byte representations:
- Hexadecimal \\xXX (default)
- Decimal values
- Octal values
- ASCII characters
.SH OPTIONS
.TP
\fB\-\-hex\fR
Hexadecimal format (default)
.TP
\fB\-\-dec\fR
Space-separated decimal bytes
.TP
\fB\-\-oct\fR
3-digit octal values
.TP
\fB\-\-char\fR
ASCII characters (non-printables as .)
.TP
\fB\-b\fR, \fB\-\-bytes\fR \fIBYTE_LENGTH\fR
Force specific byte length
.TP
\fB\-k\fR, \fB\-\-keep\-null\fR
Keep null bytes in output
.TP
\fB\-v\fR, \fB\-\-version\fR
Show version information
.SH EXAMPLES
.TP
Hexadecimal output:
.B bxxx 0x4142
\\x41\\x42
.TP
ASCII character output:
.B bxxx --char 0x414243
ABC
.TP
Decimal output:
.B bxxx --dec 0x41
65
.TP
Octal output:
.B bxxx --oct 0x41
101
.SH AUTHOR
Art of Vector
.SH COPYRIGHT
Copyright © 2024 Art of Vector. License BSD.
EOF

# Install enhanced examples
cat > "${DOC_DIR}/examples.txt" << 'EOF'
Enhanced Format Examples:
1. ASCII character output:
   bxxx --char 0x414243 -> ABC

2. Decimal values:
   bxxx --dec 0x41 -> 65

3. Octal values:
   bxxx --oct 0x41 -> 101

4. Mixed format script usage:
   #!/bin/bash
   HEX=$(bxxx 0xdeadbeef)
   ASCII=$(bxxx --char 0x68656c6c6f)
   echo "Hex: $HEX"
   echo "Text: $ASCII"
EOF

# Update man database
echo "Updating manual database..."
mandb >/dev/null 2>&1

echo ""
echo "bxxx ${VERSION} with enhanced formats installed successfully!"
echo "Try examples:"
echo "  bxxx --char 0x41424344    # ASCII output"
echo "  bxxx --oct 0x12           # Octal output"
echo "View full docs: man bxxx"
