#!/usr/bin/env bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/z3co/dotfiles.git"
REPO_NAME="dotfiles"

if ! command -v kanata; then
  echo "Install kanata first"
  exit 1
fi

echo "Adding new group \"uinput\""
sudo groupadd uinput

echo "Adding user to group \"uinput\""
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

echo "Create input rule"
sudo mkdir -p /etc/udev/rules.d/
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' > /etc/udev/rules.d/99-input.rules

sudo udevadm control --reload-rules && sudo udevadm trigger

ls -l /dev/uinput

sudo modprobe uinput

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  stow kanata
else
  echo "Failed to clone the repository."
  exit 1
fi

systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
