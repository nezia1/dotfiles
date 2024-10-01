{
  self,
  inputs,
  ...
}: {
  imports = [
    "${self}/home/services/udiskie.nix"

    "${self}/home/programs"
    "${self}/home/programs/plasma"

    "${self}/home/terminal/emulators/konsole.nix"

    "${self}/home/programs/editors/neovim.nix"

    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
}
