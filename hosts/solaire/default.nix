{ pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  modules.nvidia.enable = true;

  programs.steam = {
    enable = true;
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  hardware.keyboard.qmk.enable = true;
    environment.systemPackages = with pkgs; [
     via
  ];
  services.udev.packages = [ pkgs.via ];

  stylix.image = ../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}

