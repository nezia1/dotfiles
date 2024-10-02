{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostName = "vamos";
  environment.variables.FLAKE = "/home/nezia/.dotfiles";
}
