{ inputs, ... }:

{
  home.username = "nezia";
  home.homeDirectory = "/home/nezia";
  programs.home-manager.enable = true;
  nix.registry.shells.flake = inputs.shells;
  home.stateVersion = "24.05";
}
