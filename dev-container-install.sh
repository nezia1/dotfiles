#!/bin/sh
sudo apt update
sudo apt install fish fzf -y
chezmoi apply --force
