{self, ...}: {
  imports = [
    ./terminal
    self.nixosModules.theme
  ];
  home = {
    username = "nezia";
    homeDirectory = "/home/nezia";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
