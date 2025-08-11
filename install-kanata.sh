#!/usr/bin/env bash

REPO_NAME="dotfiles"

source packages.conf

if ! command -v kanata; then
	if ! command -v yay; then 
		echo "Yay not installed, install yay before running the script again"
		exit 1
	else
		echo "Installing kanata"
		yay -S kanata
	fi
fi

echo "Adding new group \"uinput\""
sudo groupadd uinput

echo "Adding user to group \"uinput\""
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

echo "Create input rule"
sudo mkdir -p /etc/udev/rules.d/
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-input.rules

sudo udevadm control --reload-rules && sudo udevadm trigger

ls -l /dev/uinput

sudo modprobe uinput

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git init "$REPO_NAME"
	cd "$REPO_NAME"
	git remote add -f origin "$REPO_URL"
	git config core.sparseCheckout true
	echo "kanata" >> .git/info/sparse-checkout
	git pull origin master
fi

if [ $? -eq 0 ]; then
  stow --adopt kanata
  git restore .
else
  echo "Failed to clone the repository."
  exit 1
fi

systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
