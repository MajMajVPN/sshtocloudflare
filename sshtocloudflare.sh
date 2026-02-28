#!/bin/bash

# tunnel-setup.sh - SSH Tunnel Setup Script
# Created for majmaj.ir & 262626.ir

set -e  # Stop on error

# Generate SSH key if not exists
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa" -N "" -C "tunnel-$(hostname)"
fi

# Add public key to authorized_keys
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
cat "$HOME/.ssh/id_rsa.pub" >> "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"

# Root user setup (if running with sudo)
if [ "$EUID" -eq 0 ]; then
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    if [ -f /root/.ssh/id_rsa.pub ]; then
        cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
        chmod 600 /root/.ssh/authorized_keys
    fi
fi

# Get user input
read -p "🔹 IP Iran ra vared konid: " iranip
read -p "🔹 IP Kharej ra vared konid: " kharejip
read -p "🔹 Port Iran ra vared konid: " iranport
read -p "🔹 Port Kharej ra vared konid: " kharejport

# Validate inputs
if [[ -z "$iranip" || -z "$kharejip" || -z "$iranport" || -z "$kharejport" ]]; then
    echo "❌ Error: Hame field ha bayad por shavad!"
    exit 1
fi

# Create tunnel
echo "🚀 Tunnel dar hale sakhtan..."
ssh -p 22 "$USER@$iranip" -f -N -L "0.0.0.0:$iranport:$kharejip:$kharejport"

echo "✅ Tunnel ba movafaghiat sakhte shod!"
echo "📊 Command: ssh -p 22 $USER@$iranip -L 0.0.0.0:$iranport:$kharejip:$kharejport"
