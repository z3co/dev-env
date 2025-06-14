#!/usr/bin/env bash

REPO_NAME="dotfiles"

source packages.conf

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL" "$REPO_NAME"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  for s in "${CONFIG_LIST[@]}"; do 
    if [[ "$1" == "--dry" ]]; then
      echo "[DRY] Stowing $s"
    else
      echo "Stowing $s"
      stow --adopt $s
    fi
  done
  git restore .
else
  echo "Failed to clone the repository."
  exit 1
fi

