{
  self,
  inputs,
  ...
}: {
  imports = [
    "${self}/home/services/udiskie.nix"

    "${self}/home/programs"
    "${self}/home/programs/plasma"
    "${self}/home/programs/games"

    "${self}/home/terminal/emulators/konsole.nix"

    "${self}/home/programs/editors/neovim.nix"

    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
  config.theme.wallpaper = ../../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}
