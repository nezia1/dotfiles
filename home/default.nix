{
  lib,
  self,
  ...
}: {
  imports = [
    ./terminal
  ];
  home = {
    username = "nezia";
    homeDirectory = "/home/nezia";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
