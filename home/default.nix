{
  self,
  nix-colors,
  ...
}: {
  imports = [
    ./terminal
    self.nixosModules.theme
    nix-colors.homeManagerModules.default
  ];
  home = {
    username = "nezia";
    homeDirectory = "/home/nezia";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
