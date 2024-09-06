{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.gnome;
in 
  {
  options = {
    modules.gnome = {
      enable = lib.mkEnableOption "Enable Gnome";
    };
  };
  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
   [org.gnome.mutter]
   experimental-features=['scale-monitor-framebuffer']
        '';
      };
    };

    environment.gnome.excludePackages =
      (with pkgs; [ gnome-console gnome-photos gnome-music gnome-tour iagno hitori atomix gnome-contacts gnome-initial-setup gedit cheese tali epiphany geary yelp ]);

    environment.systemPackages = with pkgs; [ 
      gnome-tweaks 
      gnome-power-manager
    ];
    stylix.fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Intel Variable";
      };
      serif = config.stylix.fonts.sansSerif;
      sizes.desktop = 9;
    };
  };
}

