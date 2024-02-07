# My dotfiles
![](./screenshots/desktop.png) ![](./screenshots/desktop-terminals.png)

These are my personal dotfiles for configuring my workstation. I use
[chezmoi](https://www.gnu.org/software/stow/) to manage them, as it just makes managing it all way more convenient, and allows me to setup everything in one command.
them to the right place.

This configuration uses git submodules in order to integrate my Emacs config in a separate repository, so make sure to
initialize them before trying to install it (installation instructions
below).

# Installing

You could install it on any Linux distribution that you want, but I
recommend Arch Linux as there is a file containing a list of required
packages installable via pacman or your favorite AUR helper.

You do require chezmoi installed on your system (you can find the installation instructions [here](https://www.chezmoi.io/install/))
-   Clone the config in your home directory
    `chezmoi init git@github.com:nezia1/dotfiles.git`
-   Get into your new chezmoi directory with `chezmoi cd`
-   Initialize submodules with `git submodule update --init`
-   If you\'re using Arch Linux, install the packages with
    `sudo pacman < arch_packages` or using your favorite AUR helper
-   `fisher update` to install fish plugins

# Theme

I use [catppuccin](https://github.com/catppuccin/catppuccin) as my theme
(the mocha variant). I love the soothing pastel colors. The GTK theme
and the Qt5 theme are also configured to be used with supported
applications.

# Shell setup

I use [fish](https://github.com/fish-shell/fish-shell) as my interactive
shell, but I still keep [bash](https://www.gnu.org/software/bash/) as my
non-interactive shell for compatibility purposes, as some pieces of
software that I use require the user to have a POSIX compliant shell.
This is why I have a bash module, where I setup everything that I want
to have non-interactively and interactively and if running
interactively, have it start a fish session.

It also keeps variables set in .profile, since we\'re starting fish from
bash.

# Software used

-   Operating system: [Arch Linux](https://archlinux.org/)
-   Window manager: [Hyprland](https://hyprland.org)
-   Status bar: [Waybar](https://github.com/Alexays/Waybar)
-   Application launcher: [wofi](https://sr.ht/~scoopta/wofi/)
-   Terminal emulator: [kitty](https://github.com/kovidgoyal/kitty)
-   Shell: [fish](https://github.com/fish-shell/fish-shell)
-   Text editor: [Emacs](https://www.gnu.org/software/emacs/)
-   Notification daemon: [dunst](https://github.com/dunst-project/dunst)
-   Password manager: [pass](https://www.passwordstore.org/)

Hyprland is configured to use a random wallpaper from the
`$HOME/.dotfiles` directory, so you need to have your wallpapers in it.

# Services and timers

The user-services module contains different systemd daemons and timers
that you might or might not need depending on your specific use-case:

-   sync: a systemd timer that synchronizes my org directory using
    [rclone](https://rclone.org/) to a remote called drive (runs every 5
    minutes)
