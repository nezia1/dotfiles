{ inputs, ... }:

{
  home.username = "nezia";
  home.homeDirectory = "/home/nezia";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
