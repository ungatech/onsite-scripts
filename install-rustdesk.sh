#!/bin/bash
# ./install-rustdesk.sh <host> <key>
relay_host="${1:-relay.unga.tech}"
relay_key="${2:-bjAtiOq+3krNi+mQCcbS0FNQvoOGqaSStUKkOCk911M=}"

echo "Verifying Flatpak and Flathub..."
sudo apt update && sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing RustDesk via Flatpak..."
sudo flatpak install -y flathub com.rustdesk.RustDesk

echo "Configuring Server & Key..."
flatpak run com.rustdesk.RustDesk --config "host=$relay_host,key=$relay_key"
echo "Waiting for services to initialize..."
sleep 3

# --- Password Verification Loop ---
while true; do
    echo "Set the Permanent Password for this machine:"
    read -rsp "Enter Password: " pass1
    echo ""
    read -rsp "Confirm Password: " pass2
    echo ""

    if [ "$pass1" = "$pass2" ] && [ -n "$pass1" ]; then
        echo "Passwords match. Applying configuration..."
        flatpak run com.rustdesk.RustDesk --password "$pass1"
        break
    else
        echo "Error: Passwords do not match or are empty. Please try again."
        echo ""
    fi
done

# --- Final Info & Cleanup ---
echo "--------------------------------"
echo "Installation complete!"
echo "Your Ungatech Support ID is:"
flatpak run com.rustdesk.RustDesk --get-id
echo "--------------------------------"

# Wipe the session history so passwords aren't stored in ~/.bash_history
history -c
history -w
echo "Session history cleared for security."
