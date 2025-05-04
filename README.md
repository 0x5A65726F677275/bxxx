Installation Instructions:
Save this script as install.sh

Make it executable:

bash
chmod +x install.sh
Run as root:

bash
sudo ./install.sh
What This Installer Does:
Creates all necessary directories:

/usr/local/bin for the executable

/usr/local/share/man/man1 for man pages

/usr/local/share/doc/bxxx for documentation

Installs:

The main bxxx Python script with proper permissions

Comprehensive man page documentation

Example usage file

Features:

Error checking for root privileges

Clean installation process

Automatic man database update

Success message with usage examples

Usage After Installation:
bash
# Basic conversion
bxxx 0x414243

# With options
bxxx -b 8 0xdeadbeef
bxxx --keep-null 0x1234

# Get help
bxxx --help

# View manual
man bxxx
The tool will be available system-wide for all users after installation.
