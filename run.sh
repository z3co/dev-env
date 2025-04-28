#!/bin/bash

clear

set -e

if [ ! -f "packages.conf" ]; then
  echo "Error: no packages.conf"
fi 

source ./packages.conf

echo "Ready to install..."

# Update system 
echo "Updating system..."
sudo pacman -Syu --noconfirm

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

for package in ${packages[@]}; do
  yay -S --noconfirm ${package}
done
