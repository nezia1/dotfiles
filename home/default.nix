{
  lib,
  self,
  ...
}: {
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

  theme.wallpaper = lib.mkDefault ../wallpapers/nix-wallpaper-nineish-catppuccin-frappe-alt.svg;
  theme.scheme = lib.mkDefault "catppuccin-frappe";
}
