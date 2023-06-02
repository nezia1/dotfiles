#!/bin/sh
[ ! -d $HOME/org ] && rclone copy drive:org $HOME
rclone sync $HOME/org --include "**.{org,png,jpeg}" drive:org


