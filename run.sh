#!/bin/bash

print_logo() {
    cat << "EOF"
________                                            
\______ \   _______  __           ____   _______  __
 |    |  \_/ __ \  \/ /  ______ _/ __ \ /    \  \/ /
 |    `   \  ___/\   /  /_____/ \  ___/|   |  \   /   Arch linux crafting tool
/_______  /\___  >\_/            \___  >___|  /\_/    Creater: typecraft, mostly
        \/     \/                    \/     \/      
EOF
}

clear
print_logo

set -e

source utils.sh

if [ ! -f "packages.conf" ]; then
  echo "Error: no packages.conf"
fi 

source packages.conf

echo "Ready to install..."

# Update system 
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install AUR helper yay if not already installed
if ! command -v yay &> /dev/null; then
  echo "Install yay AUR helper..."
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git
  cd yay
  echo "Building yay"
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "Yay is already installed"
fi 

echo "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing development tools..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing system maintenance tools..."
install_packages "${MAINTENANCE[@]}"

echo "Installing desktop environment..."
install_packages "${DESKTOP[@]}"

echo "Installing desktop environment..."
install_packages "${OFFICE[@]}"

echo "Installing media packages..."
install_packages "${MEDIA[@]}"

echo "Installing fonts..."
install_packages "${FONTS[@]}"

# Enable services
echo "Configuring services..."
for service in "${SERVICES[@]}"; do
  if ! systemctl is-enabled "$service" &> /dev/null; then
    echo "Enabling $service..."
    sudo systemctl enable "$service"
  else
    echo "$service is already enabled"
  fi
done

# Some programs just run better as flatpaks. Like discord/spotify
echo "Installing flatpaks (like discord and spotify)"
. install-flatpaks.sh

echo "Setup complete! You may want to reboot your system."
