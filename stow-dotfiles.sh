#!/usr/bin/env bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/z3co/dotfiles.git"
REPO_NAME="dotfiles"

source dotfiles.conf

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
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  for s in "${CONFIG_LIST[@]}"; do 
    if [[ "$1" == "--dry" ]]; then
      echo "[DRY] Stowing $s"
    else
      echo "Stowing $s"
      stow $s
    fi
  done
else
  echo "Failed to clone the repository."
  exit 1
fi

