#!/bin/sh
sudo apt update
sudo apt install fish fzf curl -y
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply nezia1
