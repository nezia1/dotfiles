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
      (with pkgs; [ gnome-console gnome-photos gnome-tour gedit cheese epiphany geary yelp ])
      ++ (with pkgs.gnome; [
        gnome-music
        tali
        iagno
        hitori
        atomix
        gnome-contacts
        gnome-initial-setup
      ]);

    environment.systemPackages = with pkgs; [ 
      gnome-tweaks 
    ];
  };
}
