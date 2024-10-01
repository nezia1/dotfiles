{inputs, ...}: {
  imports = [
    ../../programs/editors/neovim.nix

    ../../programs
    ../../programs/plasma

    ../../services/udiskie.nix

    ../../terminal/emulators/konsole.nix
    ../../terminal/emulators/wezterm.nix

    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
}
