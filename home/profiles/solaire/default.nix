{config, ...}: {
  imports = [
    ../../programs/editors/neovim.nix

    ../../programs
    ../../programs/games

    ../../services/udiskie.nix

    ../../terminal/emulators/gnome-terminal.nix
    ../../terminal/emulators/wezterm.nix
  ];
  config.theme.wallpaper = ../../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}
