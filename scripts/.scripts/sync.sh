#!/bin/sh
[ ! -f $HOME/passwords.kdbx ] && rclone copy drive:passwords.kdbx $HOME
[ ! -d $HOME/org ] && rclone copy drive:org $HOME
rclone sync $HOME/passwords.kdbx drive:
rclone sync $HOME/org --include "**.{org,png,jpeg}" drive:org


