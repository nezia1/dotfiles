{ config, pkgs, ... }:

{
  config = {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
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
  };
}
