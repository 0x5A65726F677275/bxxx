# Create the necessary directories
sudo mkdir -p /usr/local/bin /usr/local/share/bxxx

# Create the script file with proper permissions
sudo tee /usr/local/bin/bxxx >/dev/null <<'EOF'
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Copyright (c) 2024 Art of Vector
Byte Sequence Generator Tool
"""

import argparse
import sys

def bxxx(address, byte_length=None, remove_null=True):
    """Convert address to byte sequence with \\xXX formatting."""
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

    return ''.join(f'\\x{b:02x}' for b in byte_sequence)

def main():
    parser = argparse.ArgumentParser(
        description="Byte Sequence Generator - Art of Vector",
        epilog="Example: bxxx 0x414243 -> \\x41\\x42\\x43"
    )
    parser.add_argument('address', help="Address in hex (0x...) or decimal format")
    parser.add_argument('-b', '--bytes', type=int, help="Force specific byte length")
    parser.add_argument('-k', '--keep-null', action='store_false', 
                      help="Keep null bytes in output")
    parser.add_argument('-v', '--version', action='version', version='%(prog)s 1.0')

    args = parser.parse_args()

    try:
        print(bxxx(args.address, args.bytes, args.keep_null))
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
EOF

# Make the script executable
sudo chmod +x /usr/local/bin/bxxx

# Create a man page
sudo tee /usr/local/share/man/man1/bxxx.1 >/dev/null <<'EOF'
.TH BXXX 1 "2024-03-20" "Art of Vector" "Byte Sequence Generator"
.SH NAME
bxxx \- Convert addresses to byte sequences
.SH SYNOPSIS
.B bxxx
[\fIOPTIONS\fR] \fIADDRESS\fR
.SH DESCRIPTION
Convert memory addresses or numeric values into byte sequence representations.
.SH OPTIONS
.TP
\fB\-b\fR, \fB\-\-bytes\fR \fIBYTE_LENGTH\fR
Force specific byte length output
.TP
\fB\-k\fR, \fB\-\-keep\-null\fR
Keep null bytes in output (default strips them)
.TP
\fB\-v\fR, \fB\-\-version\fR
Show version information
.SH EXAMPLES
.TP
Convert hex address:
.B bxxx 0x414243
\\x41\\x42\\x43
.TP
Convert with fixed length:
.B bxxx -b 4 0x1234
\\x34\\x12\\x00\\x00
.SH AUTHOR
Art of Vector
.SH COPYRIGHT
Copyright © 2024 Art of Vector. License BSD.
EOF

# Update man page database
sudo mandb
