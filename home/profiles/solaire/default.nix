{config, ...}: {
  imports = [
    ../../programs/editors/neovim.nix

    ../../programs
    ../../programs/games

    ../../services/udiskie.nix

    ../../terminal/emulators/konsole.nix
  ];
  config.theme.wallpaper = ../../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}
