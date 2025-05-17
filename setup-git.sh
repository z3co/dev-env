#!/usr/bin/env bash

if ! pacman -Qi git; then
  echo "Install git first"
  exit 1
fi 

git config --global core.editor nvim
git config --global push.autoSetupRemote true
git config --global gpg.format ssh
git config --global alias.sta status
git config --global commit.gpgsign true

if ! command -v ssh-keygen; then
  echo "Install openssh first"
  exit 1
fi 

read -p "Please enter your email: " user_email
echo "Email set to $user_email"

ssh-keygen -t ed25519 -C "$user_email"

file=`ls -d $HOME/.ssh/* | grep .pub`

git config --global user.signingkey "$file"

read -p "Please enter your full name wrapped in double quotes: " user_full_name

git config --global user.email "$user_email"
git config --global user.name "$user_full_name"

echo "Now you are all set up\!"

