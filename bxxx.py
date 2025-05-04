#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Copyright (c) 2024 Art of Vector
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Art of Vector nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

Convert a memory address or numeric value into a byte sequence representation.

This function is useful for binary exploitation, low-level programming, and
working with memory addresses in exploit development. It handles both hex strings
and integer inputs, with options to control byte length and null byte handling.

Parameters:
    address (str/int): The address/value to convert. Can be:
                      - Hex string (e.g., "0x414243", "deadbeef")
                      - Integer (e.g., 0x414243, 123456)
    byte_length (int, optional): Force output to be this many bytes.
                               If None, calculates minimum required length.
    remove_null (bool, optional): If True, strips trailing null bytes (default: True)

Returns:
    str: The byte sequence formatted as \\xXX escape sequences (e.g., "\\x41\\x42\\x43")

Raises:
    ValueError: If the value requires more bytes than specified in byte_length

Example:
    >>> bxxx("0x414243")
    '\\x41\\x42\\x43'
    >>> bxxx(0x1234, byte_length=4)
    '\\x34\\x12\\x00\\x00'
    >>> bxxx("deadbeef", remove_null=False)
    '\\xef\\xbe\\xad\\xde'
"""

def bxxx(address, byte_length=None, remove_null=True):
    """Convert address to byte sequence with \\xXX formatting."""
    # Convert hex string to integer
    if isinstance(address, str):
        address = address.strip().lower()  # Normalize string format
        if address.startswith("0x"):
            address = address[2:]  # Remove '0x' prefix if present
        num = int(address, 16)  # Convert hex string to integer
    else:
        num = address  # Use integer directly

    # Calculate minimal byte length if not specified
    if byte_length is None:
        # (bits + 7) // 8 gives the minimal bytes needed to represent the number
        byte_length = (num.bit_length() + 7) // 8

    # Convert to bytes (little-endian format)
    try:
        byte_sequence = num.to_bytes(byte_length, byteorder='little')
    except OverflowError:
        raise ValueError(f"Address 0x{num:x} requires more than {byte_length} bytes!")

    # Remove null bytes from the end if requested
    if remove_null:
        byte_sequence = byte_sequence.rstrip(b'\x00')

    # Format each byte as \xXX and join them together
    return ''.join(f'\\x{b:02x}' for b in byte_sequence)

if __name__ == "__main__":
    print("Byte Sequence Generator - Art of Vector")
    print("Enter address in hex (0x...) or decimal format")
    user_input = input("> ")
    try:
        print("Result:", bxxx(user_input))
    except ValueError as e:
        print(f"Error: {e}")
