#!/bin/bash

packages=(
  zinit
  oh-my-posh
  tmux
  stow
  )

for package in ${packages[@]}; do
  yay -S --noconfirm ${package}
done
