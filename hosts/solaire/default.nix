{ pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  modules.nvidia.enable = true;
  modules.gaming.enable = true;

  stylix.image = ../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}

