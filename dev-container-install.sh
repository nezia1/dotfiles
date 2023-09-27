#!/bin/sh
sudo apt install fish fzf -y
chezmoi apply --force
fisher update
