{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostName = "solaire";
  environment.variables.FLAKE = "/home/nezia/.dotfiles";
}
