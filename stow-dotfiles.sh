#!/usr/bin/env bash

if ! command -v stow &> /dev/null; then
  echo "[ERROR] Stow is not installed"
  exit 1
fi

if [[ -e $(pwd)/dotfiles ]]; then
  echo "Using dotfiles in $(pwd)/dotfiles"
  dotfiles=`find $(pwd)/dotfiles -mindepth 1 -maxdepth 1`
  for s in $dotfiles; do 
    if basename $s | grep -q ".git"; then
      echo "[WARNING] Grep filtered out: $s"
      continue
    fi 
    echo "Stowing: $s"
    name=`basename $s`
    echo $name
    stow $name
  done
else
  echo "[ERROR] Couldnt find dotfiles in $(pwd)/dotfiles"
  exit 1
fi
