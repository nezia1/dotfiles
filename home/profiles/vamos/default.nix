{
  imports = [
    ../../programs/editors/neovim.nix

    ../../programs
    ../../programs/gnome

    ../../services/udiskie.nix

    ../../terminal/emulators/gnome-terminal.nix
    ../../terminal/emulators/wezterm.nix
  ];
  config.theme.wallpaper = ../../../wallpapers/nix-wallpaper-nineish-catppuccin-frappe-alt.svg;
}
